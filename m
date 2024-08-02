Return-Path: <linux-edac+bounces-1612-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491509459F1
	for <lists+linux-edac@lfdr.de>; Fri,  2 Aug 2024 10:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CEA11C210C7
	for <lists+linux-edac@lfdr.de>; Fri,  2 Aug 2024 08:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A251CAB3;
	Fri,  2 Aug 2024 08:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M2PCK0kI"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5211BF32B
	for <linux-edac@vger.kernel.org>; Fri,  2 Aug 2024 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722587530; cv=fail; b=LJ7tUSZrp4OFvMxMoErenyFMQWLFqobaHjY3EbSnZIqdLMDXPzk4GbtY00I17d+9D6752qy4C+htiTXBqPz6ybJH6AE8VoBRs01vG6LoJn0tAEJjPBFTDfkEOF9QgsNKuh+h7FHKSM4+NOTPFin5LYKxofu6//4BgqlOEl8YW/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722587530; c=relaxed/simple;
	bh=Sc4rtDjCFPqqM8vmiCQhpyOG6/2HIBiU8Iwdy1PhgOM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=th/BEEQ4SLD11fIvl2LoFvfPueXoXzo5FvComHqyfidmBcVeBA3CCyPos63eH3Vb1RfejvnT+cY43e8NFqVPYoI86GLRudNsNWUKZyxy+iK5q6A8lSZNrhdgR92NDm8OxYghUaPTPzc3XhgV3hr1qmyewVFmSafCQlHSVSvMsj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M2PCK0kI; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722587528; x=1754123528;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sc4rtDjCFPqqM8vmiCQhpyOG6/2HIBiU8Iwdy1PhgOM=;
  b=M2PCK0kIowsVZLC1qiYx5VrNQIhKvq++9gGJ+oyleXqTn0li1qByj68U
   g3XyF3KeN+HQjgQc3q0hzk0SvFlrZeBIFBRut+ChXfYEN0LZxkvYj3rKE
   TtkFGkbx3CYMZEhdM2MogFJjM0nHhQGZOoWLngryvd2yPn2hmAtwJur8W
   9/l6aLAlOjmkGtruTepTebcZIlviDsnfLVVEMj5vm+qTlmcSS4E20ulRT
   kAfvRK7cLmFu1UJ+hFH+FVPmg9s1xikcESaETJjCHPM8IaIbfmOb/wXOM
   IjZ1l2n7jKaQfOBhshOvb+SL5mWJtcfSdO8hHNk1L8Y03AbXUoNXDcPjn
   Q==;
X-CSE-ConnectionGUID: +/oL6Qp4R6W8Xo5816kMfQ==
X-CSE-MsgGUID: CcXvnYjOTFuroKSJIweqjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="12846679"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="12846679"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 01:32:07 -0700
X-CSE-ConnectionGUID: o65lfrBTS7mvomIVjdyS0w==
X-CSE-MsgGUID: KVMQIp0rSwabiGD1bsYgeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="78585966"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Aug 2024 01:32:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 2 Aug 2024 01:32:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 2 Aug 2024 01:32:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 2 Aug 2024 01:32:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbgXr6HudkKeeDQOp2eyrGvUC+3KkVQueuy1OqU0X1JNlQ1QEd1s6bFs+AzCu/a9QHhtuCOk8xLKmWfVPuPJaLpSsRilpQetbTbwk7NteVY5G8d4uGaqPZm7Ck5IjNd8Wg3vwjoLEn9SlFKu6R2V/gOKjdYAaVENx57bjaPBb+IN2PMizrzcLdhaRRqMQRQyaycY1+vgtNGViyvXjJF7FEuPWmNjucMY28BOWlzr/Du4Mv1bgv5Z+bDMJB6LDpQrF0/rRQvz4ivtxfitxMsp2VnGD7SVMjAoZEqWGgABq85/WJWFlzXA9BR+8G41Q7gNWPpv3oFc0YIXGBRoKS8hMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sc4rtDjCFPqqM8vmiCQhpyOG6/2HIBiU8Iwdy1PhgOM=;
 b=j8oTDteS9jT4G8FntbJEBG2gLYG+YB0W/CN+sWt3J+WNnHvKJvSurWmAR/12+dA4uKtJWPMemeMZFwRGFOuVYZzW31uamPcRLT/N+vsKudESt0/zXRDYqjVvhrG/7ueFglMZYczvbFCaw8ITmAHSKmXXehbv5fwYsZl8prbYuzt7UdQAec6x22iavwDf2PC6SvryUW/CvQttmOtlVkC49uapVrwxtbmWlBJMBYZJd9iMHUg8OIsFiBIaFp+z7ucxbJXk7rznJUwnLVYwePdeTD9AhEe/FfhSV1IRekRpqxkXMEXRrw+HEvEoLQ/6acNw6zD2oPH1VLufhZgwFElg9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA0PR11MB4622.namprd11.prod.outlook.com (2603:10b6:806:9c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Fri, 2 Aug
 2024 08:31:59 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%5]) with mapi id 15.20.7807.026; Fri, 2 Aug 2024
 08:31:59 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Borislav Petkov <bp@alien8.de>, Andres Valloud <ten@smallinteger.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, "Luck, Tony"
	<tony.luck@intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, linux-edac <linux-edac@vger.kernel.org>
Subject: RE: Unrecognized MSR report
Thread-Topic: Unrecognized MSR report
Thread-Index: AQHa31mafl/h1YR3i0mf2CDlV/Hy0rITp77Q
Date: Fri, 2 Aug 2024 08:31:59 +0000
Message-ID: <CY8PR11MB71343FB88D7F84EAD9D189E389B32@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <f5fab0e1-a6f3-4e53-a605-0aaf6d26ee3e@smallinteger.com>
 <20240726124232.GBZqOZuM0yue1Oak-A@fat_crate.local>
In-Reply-To: <20240726124232.GBZqOZuM0yue1Oak-A@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: bp@alien8.de
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA0PR11MB4622:EE_
x-ms-office365-filtering-correlation-id: 4f5ff9d0-badd-4f31-b4e1-08dcb2cd93bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b0FkeTZpTlZ4TXp6MVZtdzQxQnIxOUpEV2VwWm1xa0dGOUltSlowLzFBK1pY?=
 =?utf-8?B?YWYrblFKbzJPQmlHNGZya3hCUWw1ZTI0Z2drRGdFamdqa0Fja0wvcUtCQzJt?=
 =?utf-8?B?bzJRZU43ZzVwRGhqOGJUcUt3aS9UeW8yK1pIa1ZVWXlCcGNzU25uTERkaHda?=
 =?utf-8?B?TkIzVkNWTGVrUTdPS21xbHdiUkltbFR1NWcrQ3RZVVhnUkovbmZpWHR0WXk5?=
 =?utf-8?B?UDRzelFXWjQ3ZW45eDNLa0I0aFdaMEZrK2hVcmo1cnQwT0xXL3o3eU5WY0w5?=
 =?utf-8?B?TEhmZWZlWEZ4bndVR3VhQ1FxTTVlbldicXFrVGpka3JDemZ5d1U2OGdNSDc1?=
 =?utf-8?B?RFVwQmpWZTc4d3RPazRHOFI4RzJBVEZBY04rSCt0QnFMWUcvVzBhZUxmWWpW?=
 =?utf-8?B?bmd5dmU2VVVCMGtjcTNjazhQL3lrM2ZDRWsreENWcE9mclNmNS9RVG5QaDEr?=
 =?utf-8?B?VW8rdllZbU8xTmI2V0VpZEd6UHo3N2FYeC9vSVpHdVRKQVJuRE81OUFSTjAx?=
 =?utf-8?B?ZDNTRGd2Vm1HTU55YUcyekx4NTZVUkxIRW5oaWFsNmwvcWE0VER5NlZRYzlF?=
 =?utf-8?B?dERwQmxmbFdFdG1rSy9LSUNHc0NGUGVMNVBhNHZucWxCaVJxODEyKzc4Z0I4?=
 =?utf-8?B?eTF2T1FlZUpGTzlXYm1UU3NOTVdYcThhOE5wRnV4TEFoY1JISmF3L2pZU2dW?=
 =?utf-8?B?Q3JKczhmRFZ6ZXhRZ0NadDZld24yWXZsVzhldEZJSG4wdzNFZ0hNa2Rldm40?=
 =?utf-8?B?TWphMjcrZVdFb1dwUnJ4a0J2WVo5RCtrMnZ0cW9zejZBT25HRlg2TEJoWWlE?=
 =?utf-8?B?QWZvaVJXMzJYNlVvTkxqUEVieExvZExYdlJVWWpvb0JNR2NpZ3A2S0NXdytr?=
 =?utf-8?B?QTlzb0VuWHY3Unp4U1pHVU1kMFpkMUNmbUN4UjVUYnovSU05cnFrVWUwRndv?=
 =?utf-8?B?OWpXZnNZYUxHTjRzZlliK3F0Z2xyMUYzYVlMTUtmUE9GM0xOQ2szOXl4NndJ?=
 =?utf-8?B?a2QwNzVWaDY0L2RjQWZyYXVvczArdWJ3c3ExK1k5bGFZUWRud1BsSkxHZ29B?=
 =?utf-8?B?VXBWUzI0ZHd0MWJBT3J5cXd5bFAwdlMzelpVdmNITExhZ1Q5MWRDUGtqT1V5?=
 =?utf-8?B?MHU0clMvRWFYWXl4TTEyVENFNXMvbUhwS1J0a2s4T1NFUlNHclNmWXFmSmZG?=
 =?utf-8?B?SkQvZnViSFdQMWlpalpYcjNYbTl5Q25nVjFQaldVVHdLRi9uaU5aM2pqZ3BR?=
 =?utf-8?B?U2h5c21qcmtIOXF2MVFkWTUzSE9HSXBlcDl3M0RNaFFpQ3o5bEdtQ0FDQUNH?=
 =?utf-8?B?K2VxMUk0ZzZrbkFZMTF5eTlVOVg1QnZISGxJWUF2SmpJaWhRUWZlZ0VHWWx4?=
 =?utf-8?B?QytHWWxQRC9NcjcwUmRjYi92TEl5VDVzT24yQ1JjbkdHcDlKdHVHeEZla2Vx?=
 =?utf-8?B?ZWJNRHJ3aHJienp3VzdxRktTYjh3Yk1RWGM3RFdOZmhEQXVxcTUwd0VkdEhu?=
 =?utf-8?B?UWoycWNGckRhOTBsbHh0cVo4V3k3aEJoN0k2Tlg2S0VLYTF5UlBtK1ZuckhP?=
 =?utf-8?B?aEp1T3VFeDJZTTc2akN1dEtpQzBRQTA2Nmlsc0Z5bXRVei9uR2s2VFB1aDg5?=
 =?utf-8?B?RzZDdE95eDYxUi8wVUNRamkxQnNKUnZUOGFpOGRSbGZEN0lTSjNOSVdBN3Iv?=
 =?utf-8?B?REhxTUlHQzl0aUZacFV3eE1nY1psbHdTYW5weHlwaEtYdDF5RFE1UzBzTWNE?=
 =?utf-8?B?Wk53eHVNZlBYMXhUN2pjUVBQcFovcmlvdll1MVB3Uk5VM1RqQUFHQlgycFM1?=
 =?utf-8?B?a0xMbVZzdGtPNkM1UFZMWlZFMGVCTkRkQnJBRCtaK24xbDJ1cEs5b2RBZnNz?=
 =?utf-8?B?czlwMVVvTkNmQ3M0M0Fra0NCY1JFTDczZkJCQ2RHS3JJVVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1l5UmxOTkp4cnkrYUdETXRuY3h4Sk5kazBUU3ZzbkpvN09Gd3lxQS81emFX?=
 =?utf-8?B?dTFNTlRUcWJ1Y3kxa1RNWnJ0YURGMDNDNk1XUE1BWGNJd3N6dWxCMHU1Yllp?=
 =?utf-8?B?YmZwWjRETVVwOXZlUkhCVlRNZ1RRNVVra1YxSEE1cHFXcWlGNnVnV2NyN2Za?=
 =?utf-8?B?Ym1sSXYraUtVUHBwTjNGWExlMFhUdTQ2d2ZHYnpEaHZnelBWUUFNeG9hSFJ6?=
 =?utf-8?B?T1dXWWtkdFF0U2ZKdEQzT0NTaytHbkFpWDdzTDFiYk5CV0twM284T08vZnZX?=
 =?utf-8?B?UEg1YU5obkNaUjBuMDliUjJJcEhxK0ZpZFc4NnZNRitmNWNGVVJMZkZZQ0FP?=
 =?utf-8?B?N2RXQ1kxMndtbmZtUFJVY01XcGd4dnVNMlMwZ3lSTVpxR0FTZGZBTDRFSksw?=
 =?utf-8?B?Z0k1NHVoZUgzamFFTkNMRHArNW4zRkJ6bUloNkFkQWJvcUZ1eEk3Y0hncDM2?=
 =?utf-8?B?QUlYbnR6c01rTXpBdXlIVVdnS0Y4MDZSUEMveXVybDhhdkIvVmNKbkVXczRt?=
 =?utf-8?B?VkJTUXFzb2dyQUwzWTdvYnU5Nm5HN2REUmpFdnMzN0JjMXpaVU93bkx5MVZO?=
 =?utf-8?B?RFZROFVpZXJaOFFWcVA4bmxjUUZXbVFpTFNvb0ZVVS9CZjRuSnkwSE0wM1cy?=
 =?utf-8?B?VDc3Q0J2TXhITUcvdzhBZUR6SUQrRlZ6VHVwZlcxVjlnQTZCNE8zT1lUczNh?=
 =?utf-8?B?VGltQnlQcTBjbTRFRVJ5TWh0VmZhY3dQYTdhZmF2MHZNY0kyTUc3SmhTSzVr?=
 =?utf-8?B?LzlvZmhEYXBHN0RmQkZIaWwxSnBmbVpRdDYvM0t1dHhhOUYrVlNJenJlajFL?=
 =?utf-8?B?R3phTWF5Vy9Lald4NHEycTJwWStnL1hqZjZ1ZzNHS1BLMElHQVcvYUtuK1lY?=
 =?utf-8?B?OTRZU2Z2bW9ZWG9uL3dPenRNTk14dkVhTkUrSVhmL1F2UnM2QlVaTDRWcVFx?=
 =?utf-8?B?bTRzVnpkVksxOU5mdVlQakVWQjRtV0kzOEo3Q0FYVWJLUXo4YXplVzZGRVd3?=
 =?utf-8?B?K2xkTnZlNGJWOXdQWXlWZlZobm9yb0x2ck4ybjJaWmVoRnlwckZ6WTl5UU5p?=
 =?utf-8?B?U1RQMXJ4THBWQ0RCcWRHUHc2TUMwOSttUVhvM3YxckJGaW1IQWJvd2Y1OHVy?=
 =?utf-8?B?NTczWmFpbXZ0dGc5ZTlCOWtoRDNhdmx2L1pOQ2FuSzNHR1BVTHdpQTlxQnMr?=
 =?utf-8?B?QXRZQnBETFlpWGUxUkhWVWdla2g0MlMvd3lSZEpUU09LcytHT3JxWTBpbThQ?=
 =?utf-8?B?cE8rNkMyKzZwZHN0YWREVXk0SjU0NFJWM3I4S3g3aERYU3Y0bW9HODlVekoz?=
 =?utf-8?B?aDV6R3NTejNQM3M1OE1jY3p6blBqRFd3Z21lQVZJekdVL2grbU92ZnY5bEpV?=
 =?utf-8?B?eHVzeTFOdnhSY1Jha0RpK25DdGk3TzYvZGlPM1hYV2xLWHBMd1prOGxuMGpH?=
 =?utf-8?B?bmt1K0lZZmVlYlBpT1VOd01KczZMMENYQW9kaUtNVFJZSDBhQ2FNd1l1UUhW?=
 =?utf-8?B?QWhremVsU0JTa2c1M3N6UGRNTjI4NFJtdUY1a2RoSU9wR2FZVDM5amk0WmtB?=
 =?utf-8?B?Snk1ZllHTUdGYldNYjdKZ2djNkx3WjZtTE5vZThndExVZHV4Z3FKb1p0QjQ1?=
 =?utf-8?B?a2VOOEp1VlA0SUZTYWJ5N1JnTmdaQ0xOTDFqci95MjdJMFFSeUpzRXo1VzhM?=
 =?utf-8?B?d3hYR1huM3ZvbVdDZHBodCtOdUVmekFCWHFSMC9vVWNUMEJvMGpadjFWeENi?=
 =?utf-8?B?RUR1VE0vaEd5alVLb0xlTFJIMWlOdU4yd1ErNHREZ2pJRWgxSmlDWHVzWmRy?=
 =?utf-8?B?WWdpVmpFYTVrYk10YjBDQWFiVUgvc3ptRmF3cHZydVhUUmlTNVR3NVdHV2xt?=
 =?utf-8?B?eDBzSGlPNzlmbURxdUNDekRWdzQ5MnZST3VCME1qUlljdmh5cU1mb3NyUk9W?=
 =?utf-8?B?YnJvWUhYMWE5dDR1NDRJZXBtdWtzaXlaWkFnYjl0VWI2MDhYL0xFNzFHSUI0?=
 =?utf-8?B?SE1BUFcyall1RTN0TkJlajdZWk5sY2M3a0JOVDZmQnVtSlpGdHJjaTJWSU5p?=
 =?utf-8?B?VmN6TUVUZklHQWlSTUhmd1NwSGd1OWtLQWxrUXlOVks3cDNvZGdRLyt5RUNM?=
 =?utf-8?Q?byBKorMHYk98kH+UGzqjEJ538?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5ff9d0-badd-4f31-b4e1-08dcb2cd93bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 08:31:59.6291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A1+R8kWwKYCztyj0lD93SHnD0n3LB05jSJmDli3DxttnCK73JaS6b79AOMy6Ea7C3883CYqKQ/6Argn6ZuhSww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4622
X-OriginatorOrg: intel.com

PiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gU2VudDogRnJpZGF5LCBK
dWx5IDI2LCAyMDI0IDg6NDMgUE0NCj4gVG86IEFuZHJlcyBWYWxsb3VkIDx0ZW5Ac21hbGxpbnRl
Z2VyLmNvbT47IE1hdXJvIENhcnZhbGhvIENoZWhhYg0KPiA8bWNoZWhhYitodWF3ZWlAa2VybmVs
Lm9yZz47IEx1Y2ssIFRvbnkgPHRvbnkubHVja0BpbnRlbC5jb20+DQo+IENjOiB4ODZAa2VybmVs
Lm9yZzsgbGludXgtZWRhYyA8bGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6
IFJlOiBVbnJlY29nbml6ZWQgTVNSIHJlcG9ydA0KPiANCj4gKyBNYXVybywgVG9ueSwgbGludXgt
ZWRhYw0KPiANCj4gT24gVGh1LCBKdWwgMjUsIDIwMjQgYXQgMTI6Mjg6MjNBTSAtMDcwMCwgQW5k
cmVzIFZhbGxvdWQgd3JvdGU6DQo+ID4gSGVsbG8sIGFmdGVyIGluc3RhbGxpbmcgcmFzZGFlbW9u
IHRoZSBsb2dzIGNvbXBsYWluIHRodXMuDQo+ID4NCj4gPiBbNjA0NDc3Ljk5NTAzNl0gbXNyOiBX
cml0ZSB0byB1bnJlY29nbml6ZWQgTVNSIDB4MTdmIGJ5IHJhc2RhZW1vbiAocGlkOg0KPiA+IDI0
NDgwKS4NCj4gPiBUaGUgaGFyZHdhcmUgaW4gcXVlc3Rpb24gaXMgYSBzdXBlcm1pY3JvIHNlcnZl
ciB3aXRoIDJ4IEU1LTI2MzB2Mi4gIEENCg0KRTUtMjYzMCBpcyB0aGUgSW50ZWwgQ1BVIHdpdGgg
dGhlIGNvZGVuYW1lICJJdnkgQnJpZGdlIEVQIiB3aXRoIE1TUiAweDE3RiBjYXBhYmlsaXR5Lg0K
DQpJIHJlcHJvZHVjZWQgdGhlIGtlcm5lbCB3YXJuaW5nIG1lc3NhZ2UgYWJvdmUgb24gYW4gSW50
ZWwgU2FuZHlCcmlkZ2UsDQpUaGlzIHdhcyBiZWNhdXNlIG9mIHRoZSBkZWZhdWx0IHN5cy1ub2Rl
Og0KDQogICAgL3N5cy9tb2R1bGUvbXNyL3BhcmFtZXRlcnMvYWxsb3dfd3JpdGVzID09ICJkZWZh
dWx0Ig0KDQpJZiBJIHNldCB0aGlzIHN5cy1ub2RlIHRvDQoNCiAgIC9zeXMvbW9kdWxlL21zci9w
YXJhbWV0ZXJzL2FsbG93X3dyaXRlcyA9ICJvbiINCg0KVGhlbiB0aGVyZSB3YXMgbm8gc3VjaCB3
YXJuaW5nIGtlcm5lbCBtZXNzYWdlLiANCg0KPiA+IG5ld2VyIHNlcnZlciB3aXRoIDJ4IFhlb24g
R29sZCA2MTI4IGlzIGFsc28gcnVubmluZyByYXNkYWVtb24sIGJ1dA0KPiA+IHRoZXJlIGlzIG5v
IGNvbXBsYWludCBhYm91dCBNU1IgMHgxN2YgdGhlcmUuDQoNClhlb24gR29sZCA2MTI4IGlzIHRo
ZSBJbnRlbCBDUFUgd2l0aCB0aGUgY29kZSBuYW1lICJTa3lsYWtlIi4NCg0KQXMgU2t5bGFrZSBk
aWRuJ3QgaGF2ZSBNU1IgMHgxN2YgYW5kIHJhc2RhZW1vbiBkaWRuJ3QgdHJ5IHRvIHdyaXRlIHRo
aXMgTVNSLA0Kc28gbm8ga2VybmVsIHdhcm5pbmcgbWVzc2FnZSBvbiB0aGlzIENQVS4NCg0KPiA+
IEJvdGggc3lzdGVtcyBhcmUgcnVubmluZyBVYnVudHUgMjIuMDQgTFRTLCBmdWxseSB1cCB0byBk
YXRlLCB3aXRoDQo+ID4ga2VybmVsIHZlcnNpb24gNi41LjAtNDQuDQo+ID4NCj4gPiBUaGUgdGV4
dCBpbiB0aGUgTVNSIGRvY3VtZW50IHJlZmVyZW5jZWQgZnJvbSB0aGUgbG9ncyBvbmx5IG1ha2Vz
DQo+ID4gcmVmZXJlbmNlIHRvIEFNRCBjcHVzLiAgVGhlcmUgaXMgYWxzbyB0aGUgZGlmZmVyZW50
IGJlaGF2aW9yIGRlcGVuZGluZw0KPiA+IG9uIHRoZSBJbnRlbCBjcHUgbW9kZWwuICBUaGlzIGNp
cmN1bXN0YW5jZSBkb2VzIG5vdCBhcHBlYXIgdG8gYmUgY292ZXJlZA0KPiBieSB0aGUgZG9jdW1l
bnQuDQo+ID4gUmVwb3J0aW5nIGFzIHJlcXVlc3RlZC4uLg0KPiANCj4gVGhhbmtzLCBhcHByZWNp
YXRlZC4NCj4gDQo+IC0tLQ0KPiBGcm9tOiAiQm9yaXNsYXYgUGV0a292IChBTUQpIiA8YnBAYWxp
ZW44LmRlPg0KPiBEYXRlOiBGcmksIDI2IEp1bCAyMDI0IDE0OjM5OjUzICswMjAwDQo+IFN1Ympl
Y3Q6IFtQQVRDSF0gbWNlLWludGVsOiBEbyBub3QgZW5hYmxlIG9wdGlvbmFsIE1DRSBsb2dnaW5n
IGluIHJhc2RhZW1vbg0KPiANCj4gVGhlIGtlcm5lbCBhbHJlYWR5IGRvZXMgdGhhdCwgc2VlIGtl
cm5lbCBjb21taXQ6DQo+IA0KPiAgIDY4Mjk5YTQyZjg0MiAoIng4Ni9tY2U6IEVuYWJsZSBhZGRp
dGlvbmFsIGVycm9yIGxvZ2dpbmcgb24gY2VydGFpbiBJbnRlbA0KPiBDUFVzIikNCj4gc28gcmlw
IG91dCB5ZXQgYW5vdGhlciBjYXNlIG9mIHBva2luZyBpbnRvIE1TUnMgZnJvbSB1c2Vyc3BhY2Uu
DQo+DQoNCkp1c3QgYSBzbWFsbCBjb25jZXJuOiANCg0KVGhlIGNvbW1pdCA2ODI5OWE0MmY4NDIg
d2FzIG1lcmdlZCB0byBrZXJuZWwgdjUuMTEuIA0KRm9yIGtlcm5lbHMgPCB2NS4xMSBhbmQgdy9v
IGJhY2twb3J0aW5nIHRoaXMgY29tbWl0IG1heSBzdGlsbCBuZWVkIHRoZSByYXNkYWVtb24gdG8N
CndybXNyIDB4MTdmIHRvIGVuYWJsZSB0aGUgYWRkaXRpb25hbCBlcnJvciBsb2dnaW5nIGZvciB0
aGVzZSBjZXJ0YWluIEludGVsIENQVXMuDQoNCiBJZiBnZXQgdGhlIHJhc2RhbWVvbiB0byB3cml0
ZSB0aGUgc3lzLW5vZGUgYXMgYmVsb3cgYmVmb3JlIGRvaW5nIHdybXNyIDB4MTdmIGZvciB0aGVz
ZSBDUFVzDQogICANCiAgICAgIC9zeXMvbW9kdWxlL21zci9wYXJhbWV0ZXJzL2FsbG93X3dyaXRl
cyA9ICJvbiINCg0KVGhlbiB0aGVyZSB3aWxsIGJlIG5vIHN1Y2gga2VybmVsIHdhcm5pbmcgbWVz
c2FnZTogDQoNCiAgICAgICBtc3I6IFdyaXRlIHRvIHVucmVjb2duaXplZCBNU1IgMHgxN2YgYnkg
cmFzZGFlbW9uIChwaWQ6IDI0NDgwKS4NCg0KQEJvcmlzbGF2IFBldGtvdiwgaWYgeW91IHRoaW5r
IHRoZSBmaXggYWJvdmUgdG8gdGhlIHJhc2RhZW1vbiBpcyBhY2NlcHRhYmxlLCANCkknbGwgcHJv
Y2VlZCB0byBtYWtlIGEgZml4IGZvciByYXNkYWVtb24uIA0KDQo+IFJlcG9ydGVkLWJ5OiBBbmRy
ZXMgVmFsbG91ZCA8dGVuQHNtYWxsaW50ZWdlci5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEJvcmlz
bGF2IFBldGtvdiAoQU1EKSA8YnBAYWxpZW44LmRlPg0KPiAtLS0NCj4gWy4uLl0NCg0KVGhhbmtz
IQ0KLVFpdXh1DQoNCg==

