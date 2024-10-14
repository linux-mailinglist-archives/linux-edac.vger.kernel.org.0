Return-Path: <linux-edac+bounces-2060-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 121B199D53B
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 19:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58D0282ED0
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 17:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCD81C2327;
	Mon, 14 Oct 2024 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oohbyv1v"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EB9C2C9;
	Mon, 14 Oct 2024 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925435; cv=fail; b=bG15UWKsj/L7dYmpv+1CyPhvGj2O+tMSuOcW6D7qROU5Kzfv7pt+/dHWXb1HdSUwhvrqwceQSX7MgmUCEMeHna8jsciFCSeLidmADUMv5jonRr3oENLri+uMCWuCKUcJ8RNifCv9Dufwz0kEDljlt70u7buSAGAFxS9bUBvHl9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925435; c=relaxed/simple;
	bh=XzuoNWUrC3wyTh957RPFY/vvDadJdS0RZiInoK62OHo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UXXBCuZAbe8MVHN7z2rDRpoov/eMGHyXXOjGhfNw9PTEdsy1aflHJmr6bD07CBA6eT+iKKp+23aOOsG8JXzXimAQBYDgsBkI/VTXOLuHThhkvLZ+ee6d4+D7o98bOkI/sOYugexY/hFKGAMJ1vKSYUtB/KUyOea6EwJUCx7L4/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Oohbyv1v; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTLoZoJPIsHnZ+zzo1X5MrtsZK5WISa+oc97a5wCQS9/gxSz0ftW/r5EmwQRWUf/5nhM5bm44QWEwCR9huq7janIYxJLxjhGDlU8hShaaN/Y2iQGqnfYDcJCIF2Hlgou4q9+03UsKAr8OlNFrHaZ/RZuF7knO3zPb5egiUgx7PcGJ3KsJf2dxuCYBIlLWS1ceN9tsIMPoUvA/Y9Qc3GaDIcXRAD/7SzRiG6oyYbkpq9utEsjXn9rUbslQzjuN46alpBidFp3BZ0KcxetJ6FgR47gJ9IJra4pWJXiqZmfkJrHS+c8F2AkjWiINppcqiEH9Xpw0xkbPjxq2MZEYGfJ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uehicwoM88XVEbPBqlInFZiLu5cW+kJPFM9C3PjHk4M=;
 b=oOL6SpE9/hoViD8mkOKDavWEFSdV+3LzezbubV29s7c/100gRgViSoAKzLgSKvxSX/6Gb7al4d2ijqUOVsOH0imZVWHX5O3sB3Kt8C/x6UpmgG+PzBbuNvPf56/kxBqkwFpUhdLalG3BdL6lpNCNorFPY0lAtDXT8lbawO4FtCibTDbwy0DfVBmjrU/fwlkEua9qfJQMLfrVYSd5d2vKizhjuGYs/UDOhuWKqm4QDp2IBn5IKV0A11jKX9zmnCInbKbz5E8gAYtDmoASCPsQoFB1jm1t1Ew2GGf/EoKNnuhuC2RDRzZnjAHwCA0kRfYCubduwrdyYAq64SMlP6Vejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uehicwoM88XVEbPBqlInFZiLu5cW+kJPFM9C3PjHk4M=;
 b=Oohbyv1vb81JiSanE5YBKs8QcIqLOeTM/QysyeUw6CnsFBAW1xqVE/ZlpaqjlssDzRet/U8S0KLO1p5PaeSs7rPWefj5roi6bYdHEPoYsUptH4SNUu4XJUSDFncm/kt2E0C5UcR3VVOL57pBYaPNJ79O4D8IQkAAmHDUyKwrMJA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by DS0PR12MB8501.namprd12.prod.outlook.com (2603:10b6:8:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 17:03:51 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%6]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 17:03:50 +0000
Message-ID: <58571c24-54b6-4ae3-b666-1eee262dfb6f@amd.com>
Date: Mon, 14 Oct 2024 12:03:47 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 1/5] x86/mce: Add wrapper for struct mce to export vendor
 specific info
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Avadhut Naik
 <avadhut.naik@amd.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org"
 <mchehab@kernel.org>, "james.morse@arm.com" <james.morse@arm.com>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
 "john.allen@amd.com" <john.allen@amd.com>
References: <20241001181617.604573-1-avadhut.naik@amd.com>
 <20241001181617.604573-2-avadhut.naik@amd.com>
 <CY8PR11MB71346A3B771899EC335E444489442@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <CY8PR11MB71346A3B771899EC335E444489442@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:806:23::7) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|DS0PR12MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: 7604a2e5-0b42-4b09-0e7e-08dcec722cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OStVZkdLYkY2djRSbGNOK3RoS2ZYSHVhVjU0R2tFeFFyZ1ZqcFNjMnEwTjNE?=
 =?utf-8?B?RXp0ekFWdzZMMDBaSWs1dXhnTVlsazBuZnJlU2ZaT0NqUGxhcVFOakdkZUky?=
 =?utf-8?B?U1RieFpoVzBEOSttMmN1TjNGVmpsVjl0S3RvQWVFOHZWREMwWFUydWc3dkMr?=
 =?utf-8?B?aUZubXRmZXZna3RpM1Q3WDdmaFphYkNUZkN5V2R1dkt5WlkrVmpPN1FmeVhm?=
 =?utf-8?B?aVVOWFpTWXhqWGM2ZlV3Rytpd29ZMjhIUDU2MFVyWUhEbC92aUQzRzRzTlFo?=
 =?utf-8?B?UWJNSHVHUHB0TnNMN2s5dmVOelRtaFMxd3RyU3VoZHliMWVpeFVQbmNPUWo2?=
 =?utf-8?B?cTgyMFNFN2Qza255WGgxYlZJT3hkOHVYc1VWY1FDTFl0M0ExVjltbmoxRmxQ?=
 =?utf-8?B?RTkxdlRqcHg2K2hmbUZoZUtqa2Jhd2R5blRQWUVuckVtSGFQczdIQzlqdkgy?=
 =?utf-8?B?YW1tNWd5MHNWSVRLNDZRUTJndlNrb1dVaDZwdnpPYUVPcTBGS0RHbTQrclQ3?=
 =?utf-8?B?a08wbGdRb2tkb3FoY1YzWUN5eVdFelFwRkE2d29Za0hjMnBFakNzemovSjBY?=
 =?utf-8?B?Q1o2WnBLRStGMzU0azc5YkVPZEl3a2swVERTTThNV3pJRStVdXlzdHpkdG14?=
 =?utf-8?B?OWlPVFczK3RxMzBNdWhpWVNnK3ByY2UwTmRLSkx3RzRYVHkySXY2YTNaNVVy?=
 =?utf-8?B?TnVta3h3SksvRnphanpZUi9KclJPZjlxZi9SR0t6M2dCL2VZbWUxVmZ2MTNQ?=
 =?utf-8?B?eEZ0enFOODJuQVpQL2RpMWx4ekltODF0NjBodmtvQ1BCSmpIVzNxU1NnQmhh?=
 =?utf-8?B?M2xwVzRiaVh0S1pEUDlnWnJiQnA5RXNwWEVkcUR3TUhubUZCck91QjdvNkw0?=
 =?utf-8?B?Z3FzY3llMTB4ejY2QnlYWU9oS1IwQm5SRXlSY2xXdlZGWThiYy95V08zd25u?=
 =?utf-8?B?S2VLK2k0b2cyUDdFcmNLVzkvSDBGWkdiOUJaNWw0ZUpKWFNtL2RxaFppTkl3?=
 =?utf-8?B?U0xPWmdzV0E2TjdUam9KU3RGdHF6NitvNkRhS0VRRFh4cms4a3F0eC9URXU5?=
 =?utf-8?B?RWppelRlYWt6YUNnUDRSWjJKMkZxTkd2MTZRUG5oNXMvT29wVFc2OFREdHFh?=
 =?utf-8?B?Z29IMlJxMXBwdDJhOWs2SmRSd2l2M2RwL3Iva1BOZjQzODhUODNDSXFsRlJj?=
 =?utf-8?B?VGZpekpISW5ybGhRV1NneERoQzBoMUFqdEdobUFtQXFxSFgwQ0I5OHM4aWk0?=
 =?utf-8?B?QWQ2czl0eWxpQjNzU2QzS0p6VHQ0ZGUwd2EzT1lGL2hodUZyRkd1cGRwTU0z?=
 =?utf-8?B?UU85TDVRczVnLzVPcTB6cmpSQzkvdFpnM0k1UXhld05qYUE4L2pZU2d3Uyt5?=
 =?utf-8?B?NG9HRjhoaXQ5SzVBVnFnWUhoTDcvY1Q3U3VWc1hCajR2dVl3U1ZsMGhzQUhR?=
 =?utf-8?B?cjdoemtNUGI0U2JNOFVwYjJIYzNqMDI3WTJWcHNBbzhJMklCMnNJa1hSUE53?=
 =?utf-8?B?STA1VGwxbnpqSXFJa2wzWWNzMFBTRTMyakJWcnVPNkdyUFNDRVd3ZU5BY2xG?=
 =?utf-8?B?b1l0cjJGRzh1ZjBBY1R5dTVzRHlTNy9mY0p0SEdEOXlFclBNN05xRThxY0FS?=
 =?utf-8?B?aVk3U2ZOSFVXU1NaY3hnWlVhS241Y3JlV0oraGIwZE5nZC9aMXgreDhEakVF?=
 =?utf-8?B?M2JXb2NuMnpkdU5tZnlIeEd4VE05dy9zdnoyTmlDNlpxSURKNTdHRkpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXdmZWtOQ205b20zVmhGWDJTLzJJZGw1Rno0VUd1UGJiTDB4RGs0UjFWWm9P?=
 =?utf-8?B?cU9BL1FRSERCVEVrcVgrdUtaN0NDbnFIdWVnZmZyemlocjVNRHltc1p4OHNs?=
 =?utf-8?B?cXhieFZmVDRHSm5jUDRSblJ3ZUtKU2lWekpGa1pGaTZrVmhoWWNRUVkzZXU0?=
 =?utf-8?B?djAxQ2F5eHVINVo1TTlGdHFITk11K29MTC91Z2h6QmFJQWF0R0hEUlRxQ3F0?=
 =?utf-8?B?cGFPaUhDQ2JaWEJhWlp3M29MaXpneUExbk4xYUtzdzJtNGlURFE2S00wNFJO?=
 =?utf-8?B?OEkwWlcvbWZXazllTXMvYitvK2EvVnZoYjVCblFkaWdVTkp5TEZLbjM4dzNP?=
 =?utf-8?B?QzlRd2RHdGJGTWNYZVRTQXhxdWhtWVpLSFF0UkhkSHlZaXBUb0ZQZEdxdUFp?=
 =?utf-8?B?UkxWM2JzdXZVeURmOWtYcitLRS9nSWVMS1daRGV4N2dWZTFwbUh3YVdWNThy?=
 =?utf-8?B?OGtxSFVvZDJWSWZzeTJpQzJNdHhIWGI1UlZoTmxOQTdKSWhjbTVHMFNwWGlm?=
 =?utf-8?B?cmFVTHZzRUhpbHFKRHBYTGhHcTBKbUg4SFZBRUpKb0p5d05ja3VUUHU0ZjF3?=
 =?utf-8?B?OEppTkhIa0FSTS9HU2pGOXdwNlJheUJ4SHpLMGc1VXRnYm1nVjhyWE5kMzJL?=
 =?utf-8?B?eVdDK1NmbW5lVmQwZkgxdEhCcFNwd1FlKy9mTFNWY1dxYnZrQUI4ZFJsZVNC?=
 =?utf-8?B?SXpjQk9XemtieHE2clZTMlpUY2NvVU5aMTFoZU9LQ0VGT3pvbTc1TkN6K0RR?=
 =?utf-8?B?Q2RqZjRtd00vd0MreWVJZVpWejVoZlp4ZzUzVVBOVlhheW9DSEpJSGRnWEdG?=
 =?utf-8?B?emlMODJYWnRFZmY2OHJBamJzanRzS3Q2TTRDSnZMdENwaVRJb3VFb0NMR280?=
 =?utf-8?B?clBkdDIzTkdaYW80SnFDWFlkWFhHUmJqZTZZSW52c2tES1Nva2Zjd1NuUWtm?=
 =?utf-8?B?S1p3NVZYNFpvU3FYOGxqL0Fsc1hDMTczTVVhaVBvN25mcjlVSVpxQndQQWRV?=
 =?utf-8?B?VzlhZU5iVFJ5QThYT2VzeXZhRytoMTZTVDRTeTM3RzVGek9XeUJWUFZyNVdJ?=
 =?utf-8?B?TW44ODBzMVJlUmIzclFXQmxxbDlvMjNKTjFRc2w4VkZYQjR6b1pmTmd0RVFp?=
 =?utf-8?B?clNoNERkRU9KWE55cWRMNm5pVDdXeUZZaEJtQVlrQzVhL0Y2YnJucTFaaVYy?=
 =?utf-8?B?WkdURnlybWk0N1BmSFJNZXpJcVdVdEwybjc1eG9TUUMzc0pXMGVNMnlBSFc2?=
 =?utf-8?B?WWRLank4ckk4eTJyL3VYSXNYcnJua3BPNDhkeDJSVXpaMVY1UFBvSTdMaUcr?=
 =?utf-8?B?SmJzRnpnNXlTQVVScWhzZFV6QkRtbGtnTUJwdGptR3NJTkJLM2RVblRtWmVM?=
 =?utf-8?B?UVJDemI4RVBuK0prVUkyOWtuRGM0ZDdtMm00UWFXQ3BURnVkems4eEQ0OXdP?=
 =?utf-8?B?VlFCMFJMYkF0OXloWlA5aXpqUDlLNGlrNXlnTDdEMVNmNWp5aWlDUHo5WFlQ?=
 =?utf-8?B?QnplYlVLSFM0QmJhZzZScXlUaVMvSVdONzlleWNVV1QwN2cvSjB4RzFITXNs?=
 =?utf-8?B?Q3l5S3Z2c3ZvQmRpVDdUUGZ5YlVJOE9YS05hSkZFRWVJZkRScENydkhzTGE3?=
 =?utf-8?B?TlN4b3cwM0VlaWc1LzJPK0VYOTVRTTg3UHdHWDNLaDR2TlpuUnFNeEZTcmVR?=
 =?utf-8?B?QkhnTklTZVdYdmQvYUZpdFhQSTZlN0FuUW5udi96TmwvMjhvdFdDTnBYV0JI?=
 =?utf-8?B?clREUHJrVkIwcnNpeHNpODNEVEcvZnk2MGcrZC9VTE8yOFhrZGs3b1FsR2Yr?=
 =?utf-8?B?aGRSUzJGbHJHaDI1ZTZ2SXZYNkhvWVQ0K1VpemlUdHVYNXBUOHpNTTZvakZv?=
 =?utf-8?B?M1B0aDU0TTBoNDNGWFovZ1ZJSnBIbTB2anJ3cTljcTlvSGxnejB0L2Z6WlVJ?=
 =?utf-8?B?UUQ4VVg5ZUZlcllNb0hBdTZINFJQMWpPQjkzTHdDVndnTlRVaTZ2L3dldU1h?=
 =?utf-8?B?NEFFcEROYVVBVmdqdmF5TVpVRVEyVFpyZlpXZkw5Y1d0Q1JPTGFwWXY3ZFBX?=
 =?utf-8?B?OWwxRXh2SUN2b0pPRDQwOVd5NnRnVTJuamdKZTFNMi9ON3UxTkVqYjN5bXFk?=
 =?utf-8?Q?6sFOMolI8B1UNgvH3Pf1QDXgS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7604a2e5-0b42-4b09-0e7e-08dcec722cfb
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 17:03:50.6853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I98N+MYIcu4T1c+5d8iR1xpYOv69jTxNVTOq5SfAmpbH9UDMGk3FOMOZkX2NXKk6MX3PUMEe0k/z7dpsu4nkFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8501



On 10/14/2024 01:04, Zhuo, Qiuxu wrote:
>> From: Avadhut Naik <avadhut.naik@amd.com>
>> [...]
>> Subject: [PATCH v5 1/5] x86/mce: Add wrapper for struct mce to export vendor
>> [...]
>> --- a/arch/x86/include/asm/mce.h
>> +++ b/arch/x86/include/asm/mce.h
>> @@ -187,6 +187,14 @@ enum mce_notifier_prios {
>>  	MCE_PRIO_HIGHEST = MCE_PRIO_CEC
>>  };
>>
>> +/**
>> + * struct mce_hw_err - Hardware Error Record.
>> + * @m:		Machine Check record.
>> + */
>> +struct mce_hw_err {
>> +	struct mce m;
>> +};
>> +
> 
> Just some thoughts: 
> 
> I noticed that many places only care about the 'mce' structure instead of the new 'mce_hw_err', 
> such as the EDAC drivers in the notifier chains. 
> 
> Could we still pass these users with the 'mce' structure instead of 'mce_hw_err', 
> since they only care about 'mce'?  However, they still have the opportunity to
> get 'mce_hw_err' from 'mce' on demand with the following macro. [1]
> 
>    #define  to_mce_hw_err(mce) container_of(mce, struct mce_hw_err, m) 
> 
> So, for those codes that need 'mce_hw_err', they can retrieve it from 'mce'
> on demand by:
> 
>     struct mce_hw_err *err = to_mce_hw_err(mce); 
> 
> For those codes that don't need 'mce_hw_err', there are 
> no changes to them. I.e., they do not need to perform the extra operations 
> like below over and over:
> 
>    struct mce *mce = &err->m;
> 

Thanks for the suggestion. Will try this out and update.
>> [...]
> 
>>  static int mce_early_notifier(struct notifier_block *nb, unsigned long val,
>>  			      void *data)
>>  {
>> -	struct mce *m = (struct mce *)data;
>> +	struct mce_hw_err *err = (struct mce_hw_err *)data;
> 
> If using [1], then it can be:
>   
>     struct mce_hw_err *err = to_mce_hw_err(data);
> 
>> -	if (!m)
>> +	if (!err)
>>  		return NOTIFY_DONE;
>>
>>  	/* Emit the trace record: */
>> -	trace_mce_record(m);
>> +	trace_mce_record(err);
>>
>>  	set_bit(0, &mce_need_notify);
>>
>> @@ -597,7 +606,8 @@ static struct notifier_block early_nb = {  static int
>> uc_decode_notifier(struct notifier_block *nb, unsigned long val,
>>  			      void *data)
>>  {
>> -	struct mce *mce = (struct mce *)data;
>> +	struct mce_hw_err *err = (struct mce_hw_err *)data;
>> +	struct mce *mce = &err->m;
> 
> If using [1], then there is no need for these changes.
> 
>> [...]
>> diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c
>> b/arch/x86/kernel/cpu/mce/dev-mcelog.c
>> index af44fd5dbd7c..d991ef370efd 100644
>> --- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
>> +++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
>> @@ -36,7 +36,7 @@ static DECLARE_WAIT_QUEUE_HEAD(mce_chrdev_wait);
>>  static int dev_mce_log(struct notifier_block *nb, unsigned long val,
>>  				void *data)
>>  {
>> -	struct mce *mce = (struct mce *)data;
>> +	struct mce *mce = &((struct mce_hw_err *)data)->m;
>>  	unsigned int entry;
>>
>>  	if (mce->kflags & MCE_HANDLED_CEC)
> 
> If using [1], then there is no need for these changes.
> 
>> [...]
>> @@ -83,8 +83,8 @@ void mce_gen_pool_process(struct work_struct
>> *__unused)
>>
>>  	head = llist_reverse_order(head);
>>  	llist_for_each_entry_safe(node, tmp, head, llnode) {
>> -		mce = &node->mce;
>> -		blocking_notifier_call_chain(&x86_mce_decoder_chain, 0,
>> mce);
>> +		err = &node->err;
>> +		blocking_notifier_call_chain(&x86_mce_decoder_chain, 0,
>> err);
> 
> If using [1], then continue to pass 'mce' as before:
> 
>      mce = &node->err.m;
>      blocking_notifier_call_chain(&x86_mce_decoder_chain, 0, mce);
> 
>> [...]
>> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c index
>> ca87a0939135..4864191918db 100644
>> --- a/drivers/acpi/acpi_extlog.c
>> +++ b/drivers/acpi/acpi_extlog.c
>> @@ -134,7 +134,7 @@ static int print_extlog_rcd(const char *pfx,  static int
>> extlog_print(struct notifier_block *nb, unsigned long val,
>>  			void *data)
>>  {
>> -	struct mce *mce = (struct mce *)data;
>> +	struct mce *mce = &((struct mce_hw_err *)data)->m;
>>  	int	bank = mce->bank;
>>  	int	cpu = mce->extcpu;
>>  	struct acpi_hest_generic_status *estatus, *tmp; diff --git
> 
> If using [1], then there is no need for these changes.
> 
>> a/drivers/acpi/nfit/mce.c b/drivers/acpi/nfit/mce.c index
>> d48a388b796e..b917988db794 100644
>> --- a/drivers/acpi/nfit/mce.c
>> +++ b/drivers/acpi/nfit/mce.c
>> @@ -13,7 +13,7 @@
>>  static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
>>  			void *data)
>>  {
>> -	struct mce *mce = (struct mce *)data;
>> +	struct mce *mce = &((struct mce_hw_err *)data)->m;
>>  	struct acpi_nfit_desc *acpi_desc;
>>  	struct nfit_spa *nfit_spa;
>>
> 
> If using [1], then there is no need for these changes.
> 
>> diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c index
>> 91e0a88ef904..d1e47cba0ff2 100644
>> --- a/drivers/edac/i7core_edac.c
>> +++ b/drivers/edac/i7core_edac.c
>> @@ -1810,7 +1810,7 @@ static void i7core_check_error(struct mem_ctl_info
>> *mci, struct mce *m)  static int i7core_mce_check_error(struct notifier_block
>> *nb, unsigned long val,
>>  				  void *data)
>>  {
>> -	struct mce *mce = (struct mce *)data;
>> +	struct mce *mce = &((struct mce_hw_err *)data)->m;
>>  	struct i7core_dev *i7_dev;
>>  	struct mem_ctl_info *mci;
>>
> 
> If using [1], then there is no need for these changes.
> 
>> diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c index
>> 189a2fc29e74..091126a42884 100644
>> --- a/drivers/edac/igen6_edac.c
>> +++ b/drivers/edac/igen6_edac.c
>> @@ -919,7 +919,7 @@ static int ecclog_nmi_handler(unsigned int cmd, struct
>> pt_regs *regs)  static int ecclog_mce_handler(struct notifier_block *nb,
>> unsigned long val,
>>  			      void *data)
>>  {
>> -	struct mce *mce = (struct mce *)data;
>> +	struct mce *mce = &((struct mce_hw_err *)data)->m;
>>  	char *type;
>>
>>  	if (mce->kflags & MCE_HANDLED_CEC)
> 
> If using [1], then there is no need for these changes.
> 
>> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c index
>> 8130c3dc64da..c5fae99de781 100644
>> --- a/drivers/edac/mce_amd.c
>> +++ b/drivers/edac/mce_amd.c
>> @@ -792,7 +792,7 @@ static const char *decode_error_status(struct mce *m)
>> static int  amd_decode_mce(struct notifier_block *nb, unsigned long val, void
>> *data)  {
>> -	struct mce *m = (struct mce *)data;
>> +	struct mce *m = &((struct mce_hw_err *)data)->m;
>>  	unsigned int fam = x86_family(m->cpuid);
>>  	int ecc;
>>
> 
> If using [1], then there is no need for these changes.
> 
>> diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c index
>> f93f2f2b1cf2..a3008f6eb2b1 100644
>> --- a/drivers/edac/pnd2_edac.c
>> +++ b/drivers/edac/pnd2_edac.c
>> @@ -1366,7 +1366,7 @@ static void pnd2_unregister_mci(struct mem_ctl_info
>> *mci)
>>   */
>>  static int pnd2_mce_check_error(struct notifier_block *nb, unsigned long val,
>> void *data)  {
>> -	struct mce *mce = (struct mce *)data;
>> +	struct mce *mce = &((struct mce_hw_err *)data)->m;
>>  	struct mem_ctl_info *mci;
>>  	struct dram_addr daddr;
>>  	char *type;
> 
> If using [1], then there is no need for these changes.
> 
>> diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c index
>> d5f12219598a..f771c36540cf 100644
>> --- a/drivers/edac/sb_edac.c
>> +++ b/drivers/edac/sb_edac.c
>> @@ -3256,7 +3256,7 @@ static void sbridge_mce_output_error(struct
>> mem_ctl_info *mci,  static int sbridge_mce_check_error(struct notifier_block
>> *nb, unsigned long val,
>>  				   void *data)
>>  {
>> -	struct mce *mce = (struct mce *)data;
>> +	struct mce *mce = &((struct mce_hw_err *)data)->m;
>>  	struct mem_ctl_info *mci;
>>  	char *type;
>>
> 
> If using [1], then there is no need for these changes.
> 
>> diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c index
>> 85713646957b..5fa3a9038a77 100644
>> --- a/drivers/edac/skx_common.c
>> +++ b/drivers/edac/skx_common.c
>> @@ -644,7 +644,7 @@ static bool skx_error_in_mem(const struct mce *m)  int
>> skx_mce_check_error(struct notifier_block *nb, unsigned long val,
>>  			void *data)
>>  {
>> -	struct mce *mce = (struct mce *)data;
>> +	struct mce *mce = &((struct mce_hw_err *)data)->m;
>>  	struct decoded_addr res;
>>  	struct mem_ctl_info *mci;
>>  	char *type;
> 
> If using [1], then there is no need for these changes.
> 
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> index 1a1395c5fff1..88648a89fbdf 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> @@ -4160,7 +4160,7 @@ static struct amdgpu_device *find_adev(uint32_t
>> node_id)  static int amdgpu_bad_page_notifier(struct notifier_block *nb,
>>  				    unsigned long val, void *data)
>>  {
>> -	struct mce *m = (struct mce *)data;
>> +	struct mce *m = &((struct mce_hw_err *)data)->m;
>>  	struct amdgpu_device *adev = NULL;
>>  	uint32_t gpu_id = 0;
>>  	uint32_t umc_inst = 0, ch_inst = 0;
> 
> If using [1], then there is no need for these changes.
> 
>> diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c index
>> 90de737fbc90..78dd4b192992 100644
>> --- a/drivers/ras/amd/fmpm.c
>> +++ b/drivers/ras/amd/fmpm.c
>> @@ -400,7 +400,7 @@ static void retire_dram_row(u64 addr, u64 id, u32 cpu)
>>
>>  static int fru_handle_mem_poison(struct notifier_block *nb, unsigned long
>> val, void *data)  {
>> -	struct mce *m = (struct mce *)data;
>> +	struct mce *m = &((struct mce_hw_err *)data)->m;
>>  	struct fru_rec *rec;
>>
>>  	if (!mce_is_memory_error(m))
> 
> If using [1], then there is no need for these changes.
> 
>> diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c index
>> e440b15fbabc..be785746f587 100644
>> --- a/drivers/ras/cec.c
>> +++ b/drivers/ras/cec.c
>> @@ -534,7 +534,7 @@ static int __init create_debugfs_nodes(void)  static int
>> cec_notifier(struct notifier_block *nb, unsigned long val,
>>  			void *data)
>>  {
>> -	struct mce *m = (struct mce *)data;
>> +	struct mce *m = &((struct mce_hw_err *)data)->m;
>>
>>  	if (!m)
>>  		return NOTIFY_DONE;
> 
> If using [1], then there is no need for these changes.
> 
>> [...]

-- 
Thanks,
Avadhut Naik

