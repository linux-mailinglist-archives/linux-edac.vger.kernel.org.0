Return-Path: <linux-edac+bounces-2129-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B10A9A2BB7
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 20:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7563B1C226EC
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 18:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3101E008B;
	Thu, 17 Oct 2024 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1ASMWqkC"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81341DFE31;
	Thu, 17 Oct 2024 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188582; cv=fail; b=W6VkSPWVbEXJK7ISIL3FKYcTZ3Yvpzc5Ay3XhyQz4vkdFqcZBVTxm11jxdsEP6TWl1LEYbPw/djnxOurlRFRYk1tHJZDl+PfTVydo2p8RywyC4vtoJNVJ66KHKhvMqySdLPwdAr9hzeSe+5fTqDnvEHHbtnKkJju194VOLitiog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188582; c=relaxed/simple;
	bh=12SX/Mh9Fleq98oZOvrzhln21jdsPGH3BChAtP4HYgo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=obeRsfy3ccHXOAl66zeXU02TEN0fjN8V0E9h5gBTFpS+d6qTOfpvSNS78VGZBWdgfbLGfUfbn2+XaNw5cBektoaWFWihF38fZ9qtyBHaYTwk5xNPlXzLE3TlPuSILsTARwpK2r0XP6lJg77esnzz3w5sZe/7994KrH4FMQc8RIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1ASMWqkC; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCxSVmEPEHiSovpiK4lfXlvc7lsz9EFd/zz2C4siJ+TUicTnFghJH+9CUqexDHfqjCqMbcTy4z0wC89eUr5JDnLihIcJkHpPPOFhZPKYQT6MiHe6zqfd4SxiQ3f7ASiborC613mXMR8ryxaW5CXtjLrsMfIJVCU6cVBAPOz8Z6k6Ujj4LI+g2WSkR9Nk/0nXH2QfGLNhQn6xfzlc8IEE0vPtNTFL2Lkg4qyG42ha/rK55w2FR54DRkgUU9+E9RH5eXJ2h0iRxTvnlAtMxl4KE9O7EsYxdOORxaJTu358LZwb2CZg/WyaUz8hb3ug/8a7Vf1gtX5F+cPxf+EjeyjLug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4UNGuZ+uztAg5iS1/QKA273OlE/ydCVoLcioakpz1I=;
 b=FrdpgqVJlroNOI/vkS1rjN3r26AL7M536pa4l5dDNAGcvTvbxSROsEIfroauPWZ0mAGp4Nn5wQ7IQSwhMxDyFytIQWdyVOnLb+NrNbPZSIIkt7geiJ8B0t9ST6Dla+Q/tjYg7VdrcF5wk7Ip7ZZ9iTdI4km7r+8Bp3St1H2xWprw7h0F7MwOVPsv6cb85++3kkOVNEFMLjkcz5sgmy+pKNdEpWPipAEdd8w5tCuL3YHoX8StoNEyXk267eQG7RL27EopEKWETv6rljRYnD0eDAHpje7nkZrDArnS4Bzf8nuIGWWs/nudXDb+DrlCtdtYZGTqQhrwpd22bZvbab8RMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4UNGuZ+uztAg5iS1/QKA273OlE/ydCVoLcioakpz1I=;
 b=1ASMWqkCeX8LEhGlPXq6aUDI6nZm5IKrt0U8mKLZGZKymciFcXmcM/fJr3eXFmRzkEB5Pre7r1i3p6Im2zdTcBvHK1PDy8oR3KeZV56hvEGAmt1AKefVdkxvsc+WoJ0uzjURBXvWqvTHCAxduLMuu7VL/6CLZmU36Ln7ZmHBQnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by BL1PR12MB5947.namprd12.prod.outlook.com (2603:10b6:208:39a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Thu, 17 Oct
 2024 18:09:34 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%6]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 18:09:34 +0000
Message-ID: <d2769569-2f4b-4915-8f00-4c40e1163ef7@amd.com>
Date: Thu, 17 Oct 2024 13:09:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] x86/mce: Add wrapper for struct mce to export
 vendor specific info
Content-Language: en-US
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Avadhut Naik
 <avadhut.naik@amd.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "mchehab@kernel.org" <mchehab@kernel.org>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
 "john.allen@amd.com" <john.allen@amd.com>
References: <20241016064021.2773618-1-avadhut.naik@amd.com>
 <20241016064021.2773618-2-avadhut.naik@amd.com>
 <CY8PR11MB713407C7FA225301B9072E2589472@CY8PR11MB7134.namprd11.prod.outlook.com>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <CY8PR11MB713407C7FA225301B9072E2589472@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0176.namprd04.prod.outlook.com
 (2603:10b6:806:125::31) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|BL1PR12MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: 8854d8ae-37a8-49b5-70f1-08dceed6dada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWR0MHBPN1RmSGp2OE8wdG1jN0xJL2V6OW9mZ08ySkRCY0JkQ1U3Y0hNc1lI?=
 =?utf-8?B?N1ROVGM4Q3Q3ZXRzYjR2VmtpSnRoY1NoeXJ3VUUrR1BkUzgvYlk5RW5xNFU2?=
 =?utf-8?B?Y3N3RXJrMFNqeXRBbzJSQlJ2SVRXVklLNzRlNWhOWHdSdWM4NWJHa0RQNEZE?=
 =?utf-8?B?Q0ljMG5ENjN6Y0RCYm9McE8vaUVRUlFHWlNDRmx5eXlhR1ZjR0EzQWZLYlc0?=
 =?utf-8?B?V1VvK09Wd205RDdJSER0UmFidEN0YVlpU2FDNmh2Y25qQm9NMG1qY2lmWFd0?=
 =?utf-8?B?TUxWc0lZM1F5Z1BVVzBBNjdOUVZkd3ZmTWFHSWVQa0hGVEU1ZlFBdk5yQlJB?=
 =?utf-8?B?N0cxOGozUE5BY1VUSGNsdnVDalRKWDh4aDZ5U1Yzd2VtVTQzTjIwWjZNOW8w?=
 =?utf-8?B?ZmovVG5seFhGNDVHaTk5VktlOFVia3ZUUTBSalB2QzBiYzVNOG9jcHVmVXN1?=
 =?utf-8?B?eUhOQ0lUSWFnVmgvRGVqa1hvWlhUekVnQjBKUEhYTjRNOXh1Y1E5NmwwNmNN?=
 =?utf-8?B?ZFNOZGd3aDRBTUFSSzFzZHVETzExRGY0N0tCaFpaaXJmQlM1TEpEVlhPS3Vv?=
 =?utf-8?B?K1JwSEVJSFRPUHhic0dqekF2ZytyS1pOcDZRVFdkalI1Q20xL090eUMxaU1I?=
 =?utf-8?B?UTZOMWVHaDgrMHJidnN6MDRhc1Rvb1JMS1BTSTdOK3pKREhFMWc2YU5IY3FH?=
 =?utf-8?B?Z0JIWTNwdlBGRXJLOWVvRDNBUXJ5czJkcER6bkIzTGl2ODNxR3MweXVkWTJW?=
 =?utf-8?B?WXh5MCtWeEwvMklFcElnbm5IKzFOMm5hUzhka0xqZEhYNDk1OStUVjhqQ1Fm?=
 =?utf-8?B?VFJlREQ4dWttcTVpQVQwc1ZVY01RcEYvSUJVejErRWg4SVZNN05nZ3RYbzdE?=
 =?utf-8?B?M0hSMW16VTU2THY0QVVCNDNNcjlPNWVHYVlwblI0SWx3ejZHVzIzR3BCUzV4?=
 =?utf-8?B?b2NjMDIwYnRuZUl6V2pSY2FhR3JBaHhuQVFGb0JJcDR1enZRcEtTOUlFR20x?=
 =?utf-8?B?a25sRjRCejF1NzI4eG5wb2xCZmxYUlBiOWhLOWw3QTlsYVFDZXRjUWZlNWJs?=
 =?utf-8?B?U2hPWWhLREt5U1BjN2RWY2ZaZVZ5TDFkVlkzdGt2Z1RNMzJGTVBEdzVDL05j?=
 =?utf-8?B?ZDBnVzJTeWR5YVRRdFlCUnU1VU5pVzRlNm12UjUvdGxVMDg1OE1sWWtUK2l3?=
 =?utf-8?B?NXlXL244d0YrbUlpMUw0MmNOTkp0VDc3NTdMNXdhNFh3TWQ5ZUpBT09IcVR1?=
 =?utf-8?B?bnRZd3lVSmxzTnRnNFgwdUtPY0ZUc3AvVTkrTkxvcFlWajc5bHBsSG5GZDJZ?=
 =?utf-8?B?ZDhjeGJNL3NycUs5Q1BLdjdXSVh6YWlnMmhtZ1h1TFppa0g4OWpZaDl3S1Jt?=
 =?utf-8?B?OWRhdG5qbENOU1g0UXlFR01SL3AwR2R4c005bEJWeGRabkk3ZktRSUJnR0Rl?=
 =?utf-8?B?d3U1ZDg2WlpRWDBOSmR6QmFQTy9VSnlpVTEzT2NuUllBZDljWjdpdmhweDhB?=
 =?utf-8?B?aDB1TitNTDgvbjRSYmpDNWU2c01QNDJheHB1bmxqRHQ3YTBFTktiSUNzVlFI?=
 =?utf-8?B?dkhCQkdGbTBOR011bjF1NDJmYWdOaE4rS1EwWG0xZmdoTmNLaUgwaDVoMThv?=
 =?utf-8?B?RzRTeXNBMmZrVHBKcmdlNFphcHNlQzRnbzV2Z3h0NHlQMzUrK0hJaTl2Q3hr?=
 =?utf-8?B?aTRVTDZaTW1Rak8rYWJwdDVFUjNSY3JVSGZOYnY1WlcrRmJLMWsyMEFWOHh3?=
 =?utf-8?Q?WK4fVM6ch9Mgh/iXRMblPgUBoR0aBSqr7t10cju?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnBqeGdqYTMyWlRHMkNRejFkakIxWlRKeWFKbE1RVkVDWm5idFVXVVlVWXpV?=
 =?utf-8?B?VDJEdmRkMGl6L0FWM3dzbkN0ODJPenRxajByV082QkJ5ZVhhbkhvZXg2QkdM?=
 =?utf-8?B?QjBSVTlWV2Uvd1BpdnRZdHNvclJnUTJtNmJ3VnFJUC85TktyTUJab1N4U1Fv?=
 =?utf-8?B?ODdrV1k5dUR2QkRnUjFZd1ZXaVMzODJaa094SGU5cTZKQS8xeUFScmJvNmwr?=
 =?utf-8?B?MXF1Z1BzTlhTVnpQRHk4Zk5ZazlWS0pXY0syRGg0Mlo2OUs0VFJCeXgzSmxI?=
 =?utf-8?B?RU1IL29Ec0NYOThHL1g0aU9tN0lXcXdJaGNDL0ZpTmIyMTd2bU9iYldxT1Zu?=
 =?utf-8?B?bmR6K0wrK2VIaW9tU1pWcXRncC9XN2hEUVdkLzhPekhXVjd2WHdOSUw2YWJZ?=
 =?utf-8?B?RU9OSENORE9wdzEyZW91NTdwVnZHMUlmUjhkU2M2TGEvc0VYWlN4SXYySHpn?=
 =?utf-8?B?Ym1SZHd6VFh0UWQxT2hBN1JYZDE1RDVtMVhQT1ZuYjRIYzYrWVpVd3FDNFVL?=
 =?utf-8?B?N0Q0STdTWmdaMUszUHdjcUNSajQ2bkFDU0JNRUJuZUErdm1TYjZ4eWovc3Yv?=
 =?utf-8?B?eXdNNVdUUUtacDJVOXZ6OTlVSUNIUW5FRFBoYVNnZzcvRHJaNU5WN3R0K3JV?=
 =?utf-8?B?eGgzclNoT1U0MVF4QkQva21DbHBQMXdMeWlYN2RPVXdUWVRnWlovUUxLaHdW?=
 =?utf-8?B?a0xId1oxQkFEeGlNWERJS0xKOXlaUUxYQmdjaUQ3MmlFbi9QeFFSd09ObDJP?=
 =?utf-8?B?NEZReityN1J2V090VUZoc0RiRElzMXlRN3hqdHhOdHp1OWErdWV1ZXBkWVJB?=
 =?utf-8?B?K1VBTm53NjFZbU9tS0FscHhSdHc2ZlJ2STRXYVVwUFhzNVo5SWJmdDRKejhD?=
 =?utf-8?B?V3I4RjNtcnRDT05wWHpRSU5HYklrc1dnY3RUTVZNdW1hK1BTaDVRUEhndGI0?=
 =?utf-8?B?QUlTT3BwTytkRE92VmNPRkZXVjl3ZlBma3J2K2dCL3RDeFRhRlVCbzJISEU0?=
 =?utf-8?B?YlhjWVhLRE54cHFMcStrNWo1V0ZTVDZQNHJBN1c3bkZBWk1XNHlqREt3SFQ1?=
 =?utf-8?B?THZERWtvd3NPY09KUkgrMXVlMEhQTmlZTVNTTzRpR3M2U3g4WDFscHRTbXEz?=
 =?utf-8?B?bzNiNDZaMENvSWhDcVRWTG9rY3laYmtQdU1RTG1CME5uZDd4OXVsT2R0cWxW?=
 =?utf-8?B?KzhnMGZKb1ZoalZ4M0JuN2RJZjlqMnR3TmRuRmlSVm4rak9SQnlpLy9ic0Ry?=
 =?utf-8?B?YTRTalg4T0txbFJTa3pZY2VzL2I4WVYxTGRtcVllLzlvb1lnaCtvZXF3VG5t?=
 =?utf-8?B?MGVtNEpwUmFWZ3pNVXQ4ZlJjQWpHcWNoY2t5K2tUU09GRlpGUGtMQStxZW41?=
 =?utf-8?B?WWxxMnR3TzFHQkk0OUVOajVEVDd0Wmxscm1MdzFtREp3ZjNMZ0YvMkdGNE9F?=
 =?utf-8?B?ZisrZU02aElONEZ5S1NRRDBIZEZCNzBOaWkzbHpZM3lMTmpvUzQvbUljVXAx?=
 =?utf-8?B?eXgxdnY4ZXhLU213NWFHdlZ3N0JjM2hYSHQxR2pBaWhHV3Q1cmlUMldpM2FL?=
 =?utf-8?B?YmtiVkNmcWF3SFdkVlIwR3JsaGJCQUlNeE02clNtTVFpeUt0bWhWSnpkNlF5?=
 =?utf-8?B?dURFWWpwWDQ3ZkplSGFzdUpGVUE0dWZ3cmlQUTd6Q1BjbFBCVXNIRUU1djNu?=
 =?utf-8?B?UXhsbHZzK1UzdzBxVjhaVnptZ3llM1RGK2JCZmdkOEc2N2ZMTzFhWFYrSkN3?=
 =?utf-8?B?U0wwNEpyZ0M1YjE1eFczK3F0WnZ2WTJyUmZtNGF4R0lZdDZzcXgwNVpnTGVq?=
 =?utf-8?B?eUlNYzVrMUltZHNVRGFNUkV0QXNCcUxFNVJVMUNFbGlvUDhCUzQ2K1NqUUdp?=
 =?utf-8?B?MTJqby92ejk3WjhMbzIraVBXSkZCMVo3RlNENWJsdEhQeHVQMnJWVlJ6NFMy?=
 =?utf-8?B?RThTZVRmbGdMeVNYdDlCZDhBb0VLRlFsL0R2TEIzdmxWRVpLRDEzajBiV3Ew?=
 =?utf-8?B?UlhEYnZJc0R6YUNZNDRHcGRKMmRxTEhxKzdpcE9TZGlQT2c4a0tXUmtiSThj?=
 =?utf-8?B?amtucWp1VVlrSEdNNHp4dkVqOTdkWHVDR1VrRmJPVThHbWVRdEtLU1duZFFV?=
 =?utf-8?Q?ZCmQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8854d8ae-37a8-49b5-70f1-08dceed6dada
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 18:09:34.4290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Udykr6VajlPjzhN1Y1MGlIHNeTmIR+UoYsJTYuTKuYQrQXYriUErXLmup3eju9PuRlAcvSKwDx3BNzcI5FGfAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5947



On 10/17/2024 01:02, Zhuo, Qiuxu wrote:
>> From: Avadhut Naik <avadhut.naik@amd.com>
>> [...]
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> [...]
>> @@ -1506,13 +1528,14 @@ noinstr void do_machine_check(struct pt_regs
>> *regs)
>>
>>  	this_cpu_inc(mce_exception_count);
>>
>> -	mce_gather_info(&m, regs);
>> -	m.tsc = rdtsc();
>> +	mce_gather_info(&err, regs);
>> +	m = &err.m;
>> +	m->tsc = rdtsc();
>>
>> -	final = this_cpu_ptr(&mces_seen);
>> -	*final = m;
>> +	final = this_cpu_ptr(&hw_errs_seen);
>> +	final = &err;
> 
> It's not about getting the 'final' pointer to point to 'err', instead initialize the data it points to with 'err'.
> So, it should be:
> 
>     s/final = &err/*final = err/
> 
My bad here. Will take care of it.
Thanks for pointing it out!
> [...]
> 
> -Qiuxu

-- 
Thanks,
Avadhut Naik

