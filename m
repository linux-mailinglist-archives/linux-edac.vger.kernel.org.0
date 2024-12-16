Return-Path: <linux-edac+bounces-2726-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD009F3E61
	for <lists+linux-edac@lfdr.de>; Tue, 17 Dec 2024 00:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D087F18903B6
	for <lists+linux-edac@lfdr.de>; Mon, 16 Dec 2024 23:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DC81DD525;
	Mon, 16 Dec 2024 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qhqu9WlI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OMAA4kVK"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DB41DACBB;
	Mon, 16 Dec 2024 23:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734392341; cv=fail; b=gl/8ntf7jcNwNtsv6LxZdGHyDq59azbvdEhOcsiZbumaPZ+qUwnQfeCPECjk0CodMEFjpJZmHrvokmVlbzp18jvtfA3AQfKdYtMSQ+VIppWNUjbCe7jH2Ts3sW0SQjZVwiU3U6z6fO7Vg9hrZVIoOBk4PksDA66Q+AJB7H2GqY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734392341; c=relaxed/simple;
	bh=s46CRQw492FJEJbcerWwlunEtENHlvKHNoi8zIuSCfI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AV7yt6EAe/M2PKxavcZSG0JD8DJ/RSmTahxAn5o8uciijEfI98pogAipbaEs/PQj9rJ+PFfT+UjP0QLOmKyVJDAte5suLCdzaNDtuX+rm7YN/fU4Y3Z6Hf7PS6ayVJ+7lXLaH5VXbcp6ullQSohsMxROlwSxNm9OZqddC5EOCrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qhqu9WlI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OMAA4kVK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGMjZ2A022798;
	Mon, 16 Dec 2024 23:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=oCovIRw/OmBXkD/l1AsAyM1fWl+Hn3dGiOtcgQJw2Kc=; b=
	Qhqu9WlILCEsdKCPR5Xq9dRvqUDgWYxi+yQt9UlAbh7m++h8P9xQKzQca0FZimy7
	F+XVMb5ZN85aT1FxaSUGiGONEUMk9gBbNMTMeRNDgHu3yVU6rk81H5fQBbXpmu6A
	fDNwBrj3Ks+u45BMPA4BlkjnzI6gIF5BuQSq1hhz1wS8WJf1SsfdDjBQ5h5IBiFr
	1517evYUri8ZxyFbR7eb7tXso5uWdEVLwnY/BW4kav1KfmdfscGYWT5MIer9xCz6
	kl1vYhzIEORX8oZ24lDauZDHoRr+nNMYjcSI9+gmn9Guj4HST7gLJIEg0zo3wQfY
	O8U9LzrLDDu4lzVRtym43g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0t2cnr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 23:38:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGMmX5b032668;
	Mon, 16 Dec 2024 23:38:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fdyue2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 23:38:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVNh+M3ai25n1f3Eu2NVqEJvqsBkocPlB1chRyS7NMifL/y7ks9ykdnEfjBcC+ItCi0MuAkgPjMK0Xzek6Wb0cbKtfynRIxc3U4FNblewLgEMCuz00vhiu6WkLm2fqcAyo4s2kwjJqMqoK2Aqp6O25TFWM+FyVuOd1i/PXKA4bbIDQ19J7ztG3pE2HNXWOk/06eDu9tSQWjZZlO18kiBIohVCVKiBl6pB6qWphksGRVsFN7QaWWztLldQHUTP5g3v+padaoz93seTnwsAL9JjDk/u8Qbyk/NQIFd4rJ/KzN3BVNcBopeuovW+9UaTdwEVWO+98Iq2WODKJl8tPjUrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCovIRw/OmBXkD/l1AsAyM1fWl+Hn3dGiOtcgQJw2Kc=;
 b=A3tXuPUkvO1ZTQFCE6I9uklWatPCR4Hm6wn6owuYSFVSnXzrxjvh5C1b9TWxuc0jKu3XNSZR846CTzaov6RPGsGHxBMBJOYQ6rzaJYOW2wdqP01fWESBpgQ5+XJtCttJLrhr4Ums8UidqVmkPl7WasyA17GrT4FTHbhM5Fz3RhVKiUgmcQNk8YqOn4Y3Kg/3D2oaGKoboHSGVmQLytqKNo7oXQLcIDHIRK60KlHlt0c4nY3xsf1+BYPVd9kDURat80kn20e5v2Y/jyHqyTt5PBvbfb5Ejib8xUA2v2wrCB6f7nTYSlJIYCFg8hlqCeWxWm9f42X9yW4pEzoseChWyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCovIRw/OmBXkD/l1AsAyM1fWl+Hn3dGiOtcgQJw2Kc=;
 b=OMAA4kVKwtFWjRdGeydqTH/9vcmlNIKFGVDGK44pmDcfYq8J6Yx4UAj2lG5s0fzoZeoaH3GPwoJ2BnTFfZJ0mO++TUPjgjhLT1WzZy7N0zEf2IxNJASPCwKu21HaCRiYhrHuoz0Qd0Y/RnIbUywXfFHKOFYgPbg1ME9rANiridA=
Received: from SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5)
 by IA0PR10MB7352.namprd10.prod.outlook.com (2603:10b6:208:40b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 23:38:03 +0000
Received: from SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb]) by SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 23:38:02 +0000
Message-ID: <51d231c2-3659-461a-b6c3-d0e7f9fddfc1@oracle.com>
Date: Mon, 16 Dec 2024 15:37:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 2/3] mm: memory-failure: move return value
 documentation to function declaration
To: Shuai Xue <xueshuai@linux.alibaba.com>, yazen.ghannam@amd.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, mingo@redhat.com,
        robin.murphy@arm.com, Jonathan.Cameron@Huawei.com, bp@alien8.de,
        rafael@kernel.org, linux-arm-kernel@lists.infradead.org,
        wangkefeng.wang@huawei.com, tanxiaofei@huawei.com,
        mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com,
        naoya.horiguchi@nec.com, james.morse@arm.com, tongtiangen@huawei.com,
        gregkh@linuxfoundation.org, will@kernel.org, jarkko@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
        ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
        baolin.wang@linux.alibaba.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
        robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
        zhuo.song@linux.alibaba.com
References: <20241202030527.20586-1-xueshuai@linux.alibaba.com>
 <20241202030527.20586-3-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <20241202030527.20586-3-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::26) To SA2PR10MB4780.namprd10.prod.outlook.com
 (2603:10b6:806:118::5)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4780:EE_|IA0PR10MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: 636f0cff-8cb3-4d0b-265a-08dd1e2aaecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eExOdFRJQ2U1eGMwTS9heW4yZHo0czdxNG1jWkQwZjQ5WW9QNUtVaCt4aHJW?=
 =?utf-8?B?STlOTFZEK0lhcXRUSndxSmFwZCswaWZwcTNHNnFldnkvVWZ6SWNnZG90S04y?=
 =?utf-8?B?VUJQTlA1dkFQYW1WQkJlVnhzM3ZBdzZTREJIOVlZWkxaR0E3OGFRKzkrVGNr?=
 =?utf-8?B?c00yUlNFaHhkMzQ3VkRIN2d1TWdRbVZuOGtaek5NS1pmSEJLN2FtYUo2ZzNX?=
 =?utf-8?B?RkFtUzMxaG1KTklhVHZ3Syt3SGhjQ2YrQ2V0WTEwNVdBdWp4bjZMajhlbmJh?=
 =?utf-8?B?c043T1kybVRaNkl6Q2JtS3BYYUlVMUlRSGVYdWZ3d3djY2FXd0E0eDdycUpl?=
 =?utf-8?B?RkV0Q29xUW1XYSsrNlNhbFNzNmt2SE5uaGNaYmJmQ1kzeTJoaDdDTVdQMnJV?=
 =?utf-8?B?RUQvcXBZSUF0bm9YcjBvbnhZc2NQc2I3QXdzeWxuU3NRYXFrTGVQZ3NRMThv?=
 =?utf-8?B?bklEdEd4ZXdnOVBMbUlqSks0VDM1aUh1QVNlVzJyU3JRVzZpNTBOV2g5QUtN?=
 =?utf-8?B?QlljdUVkN0ZzR1JmdWhmYzZ2d1huTW11aXFFb212S3J2UjNMeTlHTW1ZYjJi?=
 =?utf-8?B?M1M2UmdadU1Cb2ZLU1lMMXZPcU5GbGhGY2IvZzNmWGFUSFNaTVl4NVNReVlY?=
 =?utf-8?B?NkJDMCtyL3BHK2ZMeUVndW5WRUlrRXdGWFV3bVhvTUtFcC93YnYyc0hHcjNK?=
 =?utf-8?B?TXRUbDBWUGd4djk4ejRQdllpeDdWZTYxUGNXektmZnFVVGg5dU9ZV1d3N3lS?=
 =?utf-8?B?YWE4LzVGSDJ0bC9SWHdkYktMcUtKd3BGWWJVeEJnY0RoWU9qUkNIaTFKc0Jm?=
 =?utf-8?B?a0tjb2xpMTJTbjlVN29aMUdGZUw0QXZYbm1xcWVkcWxGQkFUbWE1SGZ2blIx?=
 =?utf-8?B?a3VYR2NWRTg4MEtUb3BUR3J3S01EZGlYUVYyNEN6QXZHczQwekJFdzFDTU5i?=
 =?utf-8?B?MVdWNUJlQ3dMTkhma2cxT3VQaDFoOE1vb3hWM0JUOG4vaWFKNlQ5Q0xYK21P?=
 =?utf-8?B?MW1ScXN1eFE2Z3RGTmZqWnl2Q0JRUUUzSjhNRE5XTDJpMWNFRjY3RXdaZTlN?=
 =?utf-8?B?NTVzK2dJRTAxbHlNbzF3UGxnRGVlZHNtcHRPZyt2c2J3d2JxM2liV0cvS2k4?=
 =?utf-8?B?MjRBbmMvck0xeVJhN1V5TzY3SjJjNjV0b2I4QlAxYjJBWnRjTHR2cDhEbzlO?=
 =?utf-8?B?OVhkNUpGT0pEMXhvMFMvME42Q2ZyaTlkTzBpZXlCbHpLVFFvcEY5SkhWcmtB?=
 =?utf-8?B?OEpZa2NPQWhYWVpaYTR4VWRYREw3ZHNFOGI1RW9oYXZmVTB0Y0dDRzk4TGxJ?=
 =?utf-8?B?NTNBNzdsWTY4cm92OTNia3RFbGZFV2craDU5TzRnZzB3ZFJ3QnYwNGZsRGRP?=
 =?utf-8?B?K2RrdGRqZENVYlI2L1g2bkxDOWNJQzdhZnhqWjkrS3REYno2ZWdnb0Jaald5?=
 =?utf-8?B?ZzlIU1d1aFgxeHIxSXluMDFMaCsyVVBxYUVrcWNkMnBheWl5N0kycm1OUFh1?=
 =?utf-8?B?b0xUSzlrMWFXSXg3ZG9XMnJ1NGhTdjVuUjRUZ096YkxibXBNS3ZOWU9Dc2pQ?=
 =?utf-8?B?cnlRdHNPcE1uY2g0Q0prU3U1UG1nS0lmSi9hSTUyZ0p1eUxjSnpjelNwK05O?=
 =?utf-8?B?R3ZKclNNSjQxaWJBdjh3ZnZJUG9xc05NWS80N1pDTnFwVmlJOE5aek9xY3dP?=
 =?utf-8?B?REp1ZUJBbVRhSlRDMEJ2NHIvWXRpV0VuMVBzTWNlRG1US1hmSkYreU56WVky?=
 =?utf-8?B?S050WmRjMSsyRGJsQ3VuK2VMamJxWHo1Wm44K3FKdlVMNFFWQXhuM3p0WVd2?=
 =?utf-8?B?TSs3Qnd0UlV4YnZsYStsa0hCOER4WU9rT3UwUi9uU1c3M040THh5eWh5NHVP?=
 =?utf-8?B?bjVVSmJ1a0ZTV1hKaEZFZFQ3ZWwzSVZWQ1ZUVmVlU0RSajBKQk5jT3h0REVD?=
 =?utf-8?Q?EEiMIeb30Ms=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4780.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE0yc2JFbGZGS01mWFRaWnVQS0pNNmhVeVpod1ZGdzVLeDBoT3dtRjRmdXhl?=
 =?utf-8?B?QnJzYytOdkZubXJtMWE2ZDAwRW1LT3pUN3luVXN3QlVpQ2U5bHVuK2Y3cW1p?=
 =?utf-8?B?U2FQRXFDV1M3SW0vVXk4azkxVzNVMU9YZFpRUDk4ZThmL1V5VWsyYkt1djVu?=
 =?utf-8?B?dW1FSkczaUwxTnBFWXdOVUk2WGhhd0drSHRIelAyb2ZRcng2cVUwS0o2c3pQ?=
 =?utf-8?B?dURwVmpjakdZZ29uS05XMThWRHdLMkhuQWdQKzN1RDh2dU9Vb2pudFg2TVhy?=
 =?utf-8?B?NXFuT0JpZzNYOFVQOGRlZjRVcnh5UkhoR3JEUWhKN2ZGeGNOeDhVempxQ3lT?=
 =?utf-8?B?NUhlWDR5OXJtTklzZ0hCZ3drQ3dZRjBYVW55MnBPbU5XeUJBdWFwWlV0VVhU?=
 =?utf-8?B?Z3ZieStuNHkrRGNCUTdzUVUzamFvZmtWekgzazV5TkdkbUU5YmtNNlFhUXFy?=
 =?utf-8?B?SnpuN2M2aFdaUGtrZjhkd2lCR1BEc3YvQmdweXp0OTY1dXY1WXFBbmpDS21D?=
 =?utf-8?B?OW5EMmhnS3Y1ajJIakVxT1I0VVJ4RmhkeFBGcmdUekZ6WC9TY3ZkdUltN2ta?=
 =?utf-8?B?MWdyUnpXSm8xcEd5bHNseTVCL2l5TEd2RmxFTjByRFgyZG9TN0VKMDV4VXg0?=
 =?utf-8?B?Qkh2M2NPaGNqcGRQa042UHdRbDROeVJJZkR2SmtmR2Y0MDFmTTlYUVhnMDlV?=
 =?utf-8?B?U3IzTVNnaG9tMDVNU0p5SmtXaTh1RldFOHN3bENSMkRMNERibFFka0lmU3ln?=
 =?utf-8?B?Qm1nQU9yU1U3bk5GZ2tuVXZBSU54S1VnREVaK2NqY1FEY0FtT0ROS1Q4RFFn?=
 =?utf-8?B?UUpSRkE0UWFPNmZMZkIzNlhhYjRqeVJsYlZOSVFKa1R6NkdvbXBOdHF6TnRJ?=
 =?utf-8?B?VXhLUzlzbkxTalV6R3NJYUxUSUI2aXNRQ2dSZmgzelRqcnRtWlBNUTVUQTVP?=
 =?utf-8?B?NURDN3BLVnpxdmZCaThjU3VFWHZnYjRQbVdhOGk3Q3E4WnN4QkJrR0I5eSt1?=
 =?utf-8?B?SDl6Q0VWbXlqWk45KzZhNGtONDQ0SHZ6bUU1ZGxUNkVpUmg2b3pOcmswRU50?=
 =?utf-8?B?WThwU0huRDJTUWNaUUQvUXBTdC81cmlxSStxdTgrc3ljNGJVYnpRMDE2NVIx?=
 =?utf-8?B?QWlVZm5DQWRtcEx2WUpiS1RZWUtwRmVsVi94QThLTjhEV1UvU0hYNmlMSW9P?=
 =?utf-8?B?NllFUUpzcVBIQWNzT1dNSTdEMFUxV05pM3lwQ1diVk80dEFrRHZjZklZektB?=
 =?utf-8?B?bnVFdkd4Nm1QN1hqQjYyZTE0MHZKdjhtZzlXeHAxZHpyeEpnZ1NjT0xqSkZj?=
 =?utf-8?B?S2Fid0hYbVJnZGljMlliOTJybUdWTmtMZU00dXY1Qmw0d1M5TkplNUFZdklO?=
 =?utf-8?B?V1ZBMXMwYXVpUVN1OE9zV1ZWTE9nNVZjSE9mVjdNckpjZ21aUVVlTW8xOWwx?=
 =?utf-8?B?dm01b1l6VjM1M0dqaHpuV2dqU2RsZFJPNTc2VXZTQ3QvRWxWeTJleGlvSkV1?=
 =?utf-8?B?Q1ZVWW5oSmltakxEbHJLVWM1SG1JMk1PMUhuL2Mvcllodll6Y1djUHVUelJY?=
 =?utf-8?B?VnpOSzFkS0x1Q053c3o3OGpPazJyVUtnc3ZPVG1FSERsYXg5YnIvTWJXWTNE?=
 =?utf-8?B?a2lMSlV4TzIwMzVXU2pNc0taNXArTlcrQUVtMmlWS2FGUmpCQWhyTXI0QnZ4?=
 =?utf-8?B?YWVuakkrTDFmS0JtRzhBQmNITk1kS2IyUzBJcHpMVDVsRnRRTDNRVmtocit5?=
 =?utf-8?B?b0lzOTFVVW13KzAzeFcyYzhqTEtTV2ZmZHZtK296VUVjZmRWM2c5OE01VW5L?=
 =?utf-8?B?OWljaGIweWJ6S2FXT2huRk94cWtPcktBNmJmUnRsOWc0c2tJR1gvdmVDVlFI?=
 =?utf-8?B?aCtvVzI1UEh6Qjl2MktJZVk4Y04xVXZDejYxMC9uYWRmdlhJZkpGdjRqZGhO?=
 =?utf-8?B?b3FUaEJXV0dVSmpERDJvQUpROWNSNW5BelJ5eHBPa25UbHhkYm1vNmFnYncy?=
 =?utf-8?B?Z3lmZENHQmpMOWhPR3VVRGhZSmcxeDREcWVCU201ZGFiQm9mbjRyejgvcDNG?=
 =?utf-8?B?aFgyL3NLS01Od0JuSzNmVGlVV0tPV09RQy9EM3BGZ0pWeWMzd05vT2k0S29V?=
 =?utf-8?Q?NPRJn/UZETftb1IH3uWbxbCE0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/83Zyr/exHS2OJnsB4n3sWeu8XVFdFoow4YeXJqzqPRXbAxWnoA/vrNB9mC3DVOQ7pNRvYCoyT9wgxqoP4Ko6q462iv5Gebmpq7cKIU9EgW0JGQTLzjkjvxkAOJEuCkKApudLvyB1njG7VOUnrw7IuLGU+9T9NsbVWe7hty8bUoXc/gW2hZG8+HZEd6OtMPInUDThGFxBJNXu+23QTHTBMyJuvFlAvrHpjvD2rizNq9qrwkqKg5or7Jdd1/isDg0yajig1QpfMvVz+q7lhrYhYscFFaosqxmCiugTnOzPaFC/DU1t9S8oGeEnTFA8ePZY+R1bU/uyTDVNWBEBmzctyh6LzEHCUyGCxTMWPZlbQ5/OmmMD7BA9Kdp/+TMiUW1VqDtwc01N1ewC3Con/1Py9p3P7prPAGAgMHkbo/8UmbfklnXmDl1+urM/rE1g7Y5Catg+Xv/kxZtqbERm9stkXGR6QnPQAlblQcBfKY+1tPzG1Zr4VYLMpNRFIaT/iljR5YdaZmr4kLv9uvOyzqOytr4g6zEiT8cf/2fkC08KH455yQ5RDmYw/waqYg75jLn/UPTcDLEETXY6XDIfQ/3D/aHI1mPG6VKY7S3iWCUol4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636f0cff-8cb3-4d0b-265a-08dd1e2aaecb
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4780.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 23:38:02.8700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyiZ6CnIW8NKQsLkMFlarMu9sdaleCEqtpdm3SZecy9teMgwjVRloV4xPEqUPE9Uwh0e+ucCaSjphXgFARguxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7352
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_09,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160193
X-Proofpoint-ORIG-GUID: 4qgW32Gxn3Ons6dVNAVLaaKhzwH54U0d
X-Proofpoint-GUID: 4qgW32Gxn3Ons6dVNAVLaaKhzwH54U0d


On 12/1/2024 7:05 PM, Shuai Xue wrote:
> Part of return value comments for memory_failure() were originally
> documented at the call site. Move those comments to the function
> declaration to improve code readability and to provide developers with
> immediate access to function usage and return information.
>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>   arch/x86/kernel/cpu/mce/core.c |  7 -------
>   mm/memory-failure.c            | 10 +++++++---
>   2 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 7fb5556a0b53..d1dd7f892514 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1398,13 +1398,6 @@ static void kill_me_maybe(struct callback_head *cb)
>   		return;
>   	}
>   
> -	/*
> -	 * -EHWPOISON from memory_failure() means that it already sent SIGBUS
> -	 * to the current process with the proper error info,
> -	 * -EOPNOTSUPP means hwpoison_filter() filtered the error event,
> -	 *
> -	 * In both cases, no further processing is required.
> -	 */
>   	if (ret == -EHWPOISON || ret == -EOPNOTSUPP)
>   		return;
>   
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index a7b8ccd29b6f..14c316d7d38d 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2211,9 +2211,13 @@ static void kill_procs_now(struct page *p, unsigned long pfn, int flags,
>    * Must run in process context (e.g. a work queue) with interrupts
>    * enabled and no spinlocks held.
>    *
> - * Return: 0 for successfully handled the memory error,
> - *         -EOPNOTSUPP for hwpoison_filter() filtered the error event,
> - *         < 0(except -EOPNOTSUPP) on failure.
> + * Return:
> + *   0             - success,
> + *   -ENXIO        - memory not managed by the kernel
> + *   -EOPNOTSUPP   - hwpoison_filter() filtered the error event,
> + *   -EHWPOISON    - the page was already poisoned, potentially
> + *                   kill process,
> + *   other negative values - failure.
>    */
>   int memory_failure(unsigned long pfn, int flags)
>   {

Looks good.

Reviewed-by: Jane Chu <jane.chu@oracle.com>

-jane


