// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_app/models/job_posting.dart';
// import 'package:flutter_app/services/api_service.dart';

// class JobPostingUpdateScreen extends StatefulWidget {
//   final JobPostingWithPartner jobPosting;

//   const JobPostingUpdateScreen({super.key, required this.jobPosting});

//   @override
//   _JobPostingUpdateScreenState createState() => _JobPostingUpdateScreenState();
// }

// class _JobPostingUpdateScreenState extends State<JobPostingUpdateScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late String jobTitle;
//   late String jobStatus;
//   late String fieldIndustry;
//   late String jobLevel;
//   late String yrsOfExperienceNeeded;
//   late String contractualStatus;
//   late String salary;
//   late String jobLocation;
//   late String jobDescription;
//   late String requirements;
//   late String jobResponsibilities;
//   late int industryPartner;

//   @override
//   void initState() {
//     super.initState();
//     jobTitle = widget.jobPosting.jobTitle;
//     jobStatus = widget.jobPosting.jobStatus;
//     fieldIndustry = widget.jobPosting.fieldIndustry;
//     jobLevel = widget.jobPosting.jobLevel;
//     yrsOfExperienceNeeded = widget.jobPosting.yrsOfExperienceNeeded;
//     contractualStatus = widget.jobPosting.contractualStatus;
//     salary = widget.jobPosting.salary;
//     jobLocation = widget.jobPosting.jobLocation;
//     jobDescription = widget.jobPosting.jobDescription;
//     requirements = widget.jobPosting.requirements;
//     jobResponsibilities = widget.jobPosting.jobResponsibilities;
//     industryPartner = widget.jobPosting.industryPartner as int;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Update Job Posting',
//             style: TextStyle(fontFamily: 'Montserrat')),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: <Widget>[
//               TextFormField(
//                 initialValue: jobTitle,
//                 decoration: const InputDecoration(labelText: 'Job Title'),
//                 onSaved: (value) {
//                   jobTitle = value!;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter job title';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 initialValue: jobStatus,
//                 decoration: const InputDecoration(labelText: 'Job Status'),
//                 onSaved: (value) {
//                   jobStatus = value!;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter job status';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 initialValue: fieldIndustry,
//                 decoration: const InputDecoration(labelText: 'Field Industry'),
//                 onSaved: (value) {
//                   fieldIndustry = value!;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter field industry';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 initialValue: jobLevel,
//                 decoration: const InputDecoration(labelText: 'Job Level'),
//                 onSaved: (value) {
//                   jobLevel = value!;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter job level';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 initialValue: yrsOfExperienceNeeded,
//                 decoration: const InputDecoration(
//                     labelText: 'Years of Experience Needed'),
//                 onSaved: (value) {
//                   yrsOfExperienceNeeded = value!;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter years of experience needed';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 initialValue: contractualStatus,
//                 decoration:
//                     const InputDecoration(labelText: 'Employment Status'),
//                 onSaved: (value) {
//                   contractualStatus = value!;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter Employment Status';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 initialValue: salary,
//                 decoration: const InputDecoration(labelText: 'Salary'),
//                 onSaved: (value) {
//                   salary = value!;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter salary';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 initialValue: jobLocation,
//                 decoration: const InputDecoration(labelText: 'Job Location'),
//                 onSaved: (value) {
//                   jobLocation = value!;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter job location';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 initialValue: jobDescription,
//                 decoration: const InputDecoration(labelText: 'Job Description'),
//                 onSaved: (value) {
//                   jobDescription = value!;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter job description';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 initialValue: requirements,
//                 decoration: const InputDecoration(labelText: 'Requirements'),
//                 onSaved: (value) {
//                   requirements = value!;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter requirements';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 initialValue: jobResponsibilities,
//                 decoration:
//                     const InputDecoration(labelText: 'Job Responsibilities'),
//                 onSaved: (value) {
//                   jobResponsibilities = value!;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter job responsibilities';
//                   }
//                   return null;
//                 },
//               ),

//               TextFormField(
//                 initialValue: industryPartner.toString(),
//                 decoration:
//                     const InputDecoration(labelText: 'Industry Partner'),
//                 keyboardType: TextInputType.number,
//                 onSaved: (value) {
//                   industryPartner = int.tryParse(value!)!;
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter industry partner';
//                   }
//                   if (int.tryParse(value) == null) {
//                     return 'Please enter a valid number';
//                   }
//                   return null;
//                 },
//               ),

//               // TextFormField(
//               //   initialValue: industryPartner,
//               //   decoration:
//               //       const InputDecoration(labelText: 'Industry Partner'),
//               //   onSaved: (value) {
//               //     industryPartner = value!;
//               //   },
//               //   validator: (value) {
//               //     if (value == null || value.isEmpty) {
//               //       return 'Please enter industry partner.';
//               //     }
//               //     return null;
//               //   },
//               // ),

//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     JobPostingWithPartner updatedJob = JobPostingWithPartner(
//                       jobId: widget.jobPosting.jobId,
//                       jobTitle: jobTitle,
//                       jobStatus: jobStatus,
//                       fieldIndustry: fieldIndustry,
//                       jobLevel: jobLevel,
//                       yrsOfExperienceNeeded: yrsOfExperienceNeeded,
//                       contractualStatus: contractualStatus,
//                       salary: salary,
//                       jobLocation: jobLocation,
//                       jobDescription: jobDescription,
//                       requirements: requirements,
//                       jobResponsibilities: jobResponsibilities,
//                       industryPartner: industryPartner, coverPhotoUrl: '',
//                     );
//                     Provider.of<JobPostingApiService>(context, listen: false)
//                         .updateJobPosting(updatedJob)
//                         .then((_) {
//                       Navigator.pop(context);
//                     });
//                   }
//                 },
//                 child: const Text('Update Job Posting'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
