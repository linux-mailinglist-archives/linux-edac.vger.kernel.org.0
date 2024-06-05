Return-Path: <linux-edac+bounces-1197-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127F68FD920
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 23:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BE6FB25C11
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 21:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6638E16EC05;
	Wed,  5 Jun 2024 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="oiMVDZgn"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2106.outbound.protection.outlook.com [40.107.223.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02BA16E864;
	Wed,  5 Jun 2024 21:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623209; cv=fail; b=CSJcT7qz0VXp+meoC8jnTX8GnP7fQjvs39jGgR8oAHMkwohDGHGWyR07vx5ZEFQSnYLT6WNpDqZX/oiJ3fBZb/o/JeCbaT7J89euhxs8TaPJwl/skw9fi4DPxrIhdv+sZi//bdGOSGSPJL5WMjazhFoL99Gbhwftjye+kYA/asQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623209; c=relaxed/simple;
	bh=V3pYop5ocUZ+zKcpfYHejI6L2xxqghuLK9tnZ+b4QY4=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KVDQ2eI+ACNWp8PcMVdQp4sZqGx8xWi6ds2A5Zm3nluqcvS/6o0w+yMBHzdH1u36OWm15cxltH/+GVcqLIl7itfw2M/EHwElFI4DmcJcJyinQFL8tzpSqb+DV3yDP5tmiCPuHTEHhZeIf8I98MvPJofzoaednK8+4mnjjUaST3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=oiMVDZgn; arc=fail smtp.client-ip=40.107.223.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ijl2CDJYhyL7cllGN9W8w4Cp78fzZUHsQ+TMUTVGP+1ixL8h4B/h3zO3IAxtBJzw7P22Ucle1hsD0Rh0y51916huhmEPHwEY56EBmKpjbVSa0d0c0V1BN+sIbzYo8M/NkToW4j6jyvdBYtPsoWVtixP/aQMJYsM1FEvLEKRMiOfBniWBQ/5Vr2scsUlwmZHOWmOU9xI1ZkU+wEdTmC5Z9hA+hcXlj78HC0rd5aexPZ0nQN+Ofw9Ok2ER/YbeU9unLOD/03iDjIYPTArEfjoCtdvy0XRfYo6rzaBIxNBr3VMbDwq6n91w2a8tVLorFThH/2RGoBG3qD4Boz+iq270bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPakuIFUQFQa4L3tBLRFi5uJaB/sqYalIbCcZrt7VZU=;
 b=I2s5R0NB3s3WLaVuBnfDfA7gCEi7DoN+SzHvoo+xTOV/76sHOKztl6qPB5R6a48peLRwdfrjBBzj+NpNscmOvw0qKH4U53nAQE6R7ZO4CwnyS+i3Zp+fad1czAbDfyQJqFjnVa5pubvmo+2H4fnlHMbl+GhbSBTZb178Jguc2fReI1x5KYi+LOh91zp5B9uOKCjBmWOHjsliI+9Nzj9YQPCuEevDgDn8HOGYFasLWGuU0HuUrIopO3sqZe+m/i4dLrdaedwJN7ZnexWhMQw2QBFIZmI4ohhytla0oveS/1wMU3yqhaTzyy1BSQxWxSpj3x6wvfazZfNkYgtluB8+hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPakuIFUQFQa4L3tBLRFi5uJaB/sqYalIbCcZrt7VZU=;
 b=oiMVDZgnXBmkoGKikqMCCyub75qeYJi+lnM1DTuzz7AcPOWGoQWehIVNRDLARNA5oxu9hgCwFEfXM9TZ1dj3xrM8db7pkiGFmeSY+sXgwsuD4tid7i11MbsHUqgSYLDEHiWbC4CVEe00MN87G3D6Rs+y412RUrc0noapPDObdWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CO1PR01MB7370.prod.exchangelabs.com (2603:10b6:303:159::16) by
 LV3PR01MB8462.prod.exchangelabs.com (2603:10b6:408:1a7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.27; Wed, 5 Jun 2024 21:33:25 +0000
Received: from CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::6e98:87d1:5562:ad73]) by CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::6e98:87d1:5562:ad73%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 21:33:25 +0000
Message-ID: <fcd0621b-dd68-4e0d-96e1-15c16a3278d0@os.amperecomputing.com>
Date: Wed, 5 Jun 2024 14:33:22 -0700
User-Agent: Mozilla Thunderbird
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Subject: Re: [RFC PATCH v8 10/10] ras: scrub: ACPI RAS2: Add memory ACPI RAS2
 driver
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 david@redhat.com, Vilas.Sridharan@amd.com, leo.duran@amd.com,
 Yazen.Ghannam@amd.com, rientjes@google.com, jiaqiyan@google.com,
 tony.luck@intel.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
 rafael@kernel.org, lenb@kernel.org, naoya.horiguchi@nec.com,
 james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
 erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
 mike.malvestuto@intel.com, gthelen@google.com,
 wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
 wbs@os.amperecomputing.com, nifan.cxl@gmail.com, tanxiaofei@huawei.com,
 prime.zeng@hisilicon.com, kangkang.shen@futurewei.com,
 wanghuiqiang@huawei.com, linuxarm@huawei.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave.jiang@intel.com,
 jonathan.cameron@huawei.com, dave@stgolabs.net, dan.j.williams@intel.com,
 linux-mm@kvack.org, linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20240419164720.1765-1-shiju.jose@huawei.com>
 <20240419164720.1765-11-shiju.jose@huawei.com>
Content-Language: en-US
In-Reply-To: <20240419164720.1765-11-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:303:8f::26) To CO1PR01MB7370.prod.exchangelabs.com
 (2603:10b6:303:159::16)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR01MB7370:EE_|LV3PR01MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d775375-8cb4-4fc9-def5-08dc85a721ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|1800799015|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXQ0MnRqb0d6SEw3YUo4anU2K2t4Zm93Tno1VFM2R3NkL0ZHNTNVU3VvbVFS?=
 =?utf-8?B?R01jUjZlbTQ2ZEloMDl6WVF0Z1JkWCtBY2xCL2Myd3VZOHhuSjVsb1RxZHha?=
 =?utf-8?B?RlBtWkorNVdOa3k1dWZRMzd2WVgyTkV0dytrRW02OFBNdm10eHUzUVRxR2pP?=
 =?utf-8?B?eTNnZTdQVGI5ejV2SGdZNHZSRjFVeE9UTlZNR1ArRit2Q21URXVndXVqSUth?=
 =?utf-8?B?emtuZG5EbEZwSEJUSG5sNVJiajFZNmM2czIreFNmalN5c2hneU5VY0k4em5P?=
 =?utf-8?B?azN1Z2pIUy9vdHNsNW15VWZ3dGxEd1hXdzJJais0VUEwTFp3eEFUQ1MvaEU0?=
 =?utf-8?B?MUh1cExnYVhaZmRVWFRKR1pjeHFOYURnR2IzdHhsR0Z2WVA5V2JEWTlrbnJY?=
 =?utf-8?B?WGpsdFRaS2VsQTQwV0ZyZThFNlNXWnp3ZXVBR2Nma3V1bnIySzJrZDF3Y2Fs?=
 =?utf-8?B?OWZVNTdXampLVGlCVTdWa0Z1QzJtTVg0aWZBSkVWNkxlc3Y2UmtMODlYWVBT?=
 =?utf-8?B?MlJ4ZlExTkVwNHRySXRiNXU1TllVL2RmZTlnanQxSlcwdU9sMU5lQkVUQ2tz?=
 =?utf-8?B?OTRMLzMxN1UvNThLVEJkOThzMXhmWmhKSzJnY1ZDb2dKNjNsV0ZmZlBoaDdu?=
 =?utf-8?B?VHZiRHJ6R2pPc0ZWSXc1dWFMbFgyYXNLTVFIVW9LMWc3d3V0ZHo2T0hNaWdT?=
 =?utf-8?B?R3F2MUFRcUpFbmVHUTluN1FySVpmR1Arb1RiaysxdDBCTU8xSjBuam0rVncy?=
 =?utf-8?B?QW5sZGQ4MGZ4MTFiVENLcXA0TUZJZEFQTE5sSml5Nmc0TVh5M1Zrd3pRdWxL?=
 =?utf-8?B?c0cwQk1MYnErOHJXTlZncXNqS2lLbmh0NU5IcXZmWjZtVHJLMEVUMUt5TUhV?=
 =?utf-8?B?bnNuZmU4NS9ORzFMcG5OWE1pSjBybXloQlV4eTY2MDVzSlgzczFHTFJOaC9i?=
 =?utf-8?B?WnVXdDBOK0YxVDI1dFZVOG9lYVAwdXRkd0VXMXhYQm5SeXROamxpRnhldm1X?=
 =?utf-8?B?d0tOdWN4eEZqdUdxcVFHREE5aklCSlNuaHFtbG1OQ1h0RWkweDlFVFQ0UWN1?=
 =?utf-8?B?REZ4U1g4Q2RPTHdwTXhkL2ltVEJSU3BPWWFJVC9jUFJCNHp2clBHMFZQeGlI?=
 =?utf-8?B?YXdFZnljRmRJNUVqZHg1VzNDaGttK0VUbWdFL1pRNHl6T2dyRzlkbFh2Y3hL?=
 =?utf-8?B?blkrSS9GQkJ6UzVya2dLbHdmazZPR3ZKV0NXREhLTlc3VEg3dWtIcTNOOEpY?=
 =?utf-8?B?NWRUU09JYzRQcmtPcmZ1Q1A5aXlSQWRWdWI5ZlBJdVZhMGNlclN0a3J6cXI0?=
 =?utf-8?B?aXA2MGxBQ3BOUjk4ZXNINFB5NDVBUzJnZ2tOTEZkMmRHMFZDc09ZdGViVzJw?=
 =?utf-8?B?WjdoNllyOWEwaVlhbEU2amoxVVVuSUFuUWZneXhsdjhmMWNYM2JaNFFvZXFV?=
 =?utf-8?B?VTBxdFZDdmJYb21CRWp3WjNpNFd0QmhrVGRtY1VhQWdIYlQrZzR1cHltU0pE?=
 =?utf-8?B?WGFNTFN1TW5pQ3d3eXQxOCtVaVYxQXdEdUFROHdCR0V1aWF2dGtNU1dSelBz?=
 =?utf-8?B?ZmlGd1lPc1R5ckNQUFdoZit2WlJ3TktTd1NYZ0RicnF0ZXN1WTJ0L245NFJI?=
 =?utf-8?B?SklwT1paNzVodCs4amNQeUpvT3ZjcXRwaGFMT2VHd2lSa05vbytwcVhLdkZS?=
 =?utf-8?B?KzNQdHlzaXdkaGtVVlVHRktLbzhCOENtTVdGbGxORGYxZ2IyOU1aekx6bllr?=
 =?utf-8?B?cFR3Qm5hRUY5bUE1Y1ZWdjlUdzU4YnQ2MTdYRUpHU2d2U0d1TUppUlVuNDRl?=
 =?utf-8?B?ZGlQUUVBWGhSQkR6VHRmQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR01MB7370.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGlRb25rRDJuK3lRbWNDSE5GTktMMXhtdmRzVkU1U2MwT2cwc1hXckdTTk83?=
 =?utf-8?B?U05Bd056Ylk4QW5HZkVnMStJQWRnU29MdkNhb3lGdWRWckZZOUR4OUNLNWtC?=
 =?utf-8?B?aUJ4RDNtdlNSSUVVWTc1MzZtakVHcW00QTBOeHVRamtuUStHalovR2YweVdB?=
 =?utf-8?B?R25NcVcvVktxMStNeTh0NE9Kd0I1VUlNSDN0bnhTWklpT3lSbXRZTW4rMEhz?=
 =?utf-8?B?cElDa1RDZC9XUGxqc1hURnhEY0ZkVnpObzVTSlRKSEhHTGY3V1BHOE82eEs4?=
 =?utf-8?B?b2RGbHR6SExrNVZVbzhsRC9zTW9KQmkrb3dPSU9vRGtRTmhZTEwyclB1UkpS?=
 =?utf-8?B?cVQwdWlHTTd1NkI2SWZyM25ZNStZYXRYYnY5VzFwSXFYZ2sweHVGSG9LK25n?=
 =?utf-8?B?WjFxbExvN3hqOUwrUmR5NXRjZzNMTHBiWWlFdWptWm1PY3lCNm8wYVRkclJy?=
 =?utf-8?B?ejlVUkJnT2txaDdBM1Zua0RsNmVlb0xKaFR4ck0ydVpJODZnM09uZm9GMUIz?=
 =?utf-8?B?Z010QTdhVHdVQ2NzMUtEcTQ2clNpQTFDSWNSd0s5YTh3TFdaN085c040QUtD?=
 =?utf-8?B?VGZKckZHN3pJN3p6c01OeTk3ZlBTcFM2ajJNZDZ5eVdkQmx3dmdOclg5S05i?=
 =?utf-8?B?K1o5K2VTUURFWjdWYjJ5eGUzeGFrQW9XN1RnOXpUY0N3L1Q1SXFtbmJ0UzJr?=
 =?utf-8?B?T1ZRUUhvbGh1dUVraVlhYllIY2JvK3JZUnEvdDZkS21jWVBYeXcvWWlteUZq?=
 =?utf-8?B?anJoRmdkOEE3S3grdyt1bHlvRFM3V1NtN2VjNjFYSHRiZnhNNWtPSmV6T1g0?=
 =?utf-8?B?U0ppcnJFendaY3NrQTNvU3lQRXJVb3RCWEUyZmhLQWxQczdlNVlDWDlkSDlT?=
 =?utf-8?B?WkNKWXdyV2VlQ3ZMMDVSR1hrRjBIQU9hSys4S2c1M09OMVNDRDRsa3JWL2V6?=
 =?utf-8?B?ZktmcTh6UzlkSGQ5aG91K3VMNTlDSTQxbU1TZ0RmdWdYckZlMTU1SHBKSU1j?=
 =?utf-8?B?QWRsOUxJZFFBU3pkOEQ5anM5a2wzMEFsaHlnUTkyL1dRUDdPWC90R3dta1pP?=
 =?utf-8?B?Q1grc3VrNTJiaFRZdFhJU21seE9LM0c5QmlzVkxRVjJXa0dNUWE2TnZKZDFt?=
 =?utf-8?B?dzA3Um5kWHZ5UFh0SFJGNWl6MndEZkFaVWY5ZjcwYThQVk9SakN5ZGthMGdp?=
 =?utf-8?B?K0JQclBNR1lWam5NZzk3bC9kbU92TVdtRzVZczlnUStORXVVWE1hZGdXR2Vm?=
 =?utf-8?B?amZWOTU5d3lISkowNUdQdkJoSXJEZThhWUJldDlRdWI1NFNsWXhvcGordU5R?=
 =?utf-8?B?aEEzUGpEUFA5b0o0a1orMVdqYk1aWG83ZjE5TDJqd3hRcE5vN2NhSFNic0Qv?=
 =?utf-8?B?M0FDcEpSUFVJN2x2cDM1WnpGZW5jbEhvY1llYWNPdW9Ca1NEaGR2VGFyMmJn?=
 =?utf-8?B?TXNYcFVwWWlUVUU1Q3QwOU9OMkE0MDFwVk1ZS2xWWmNUTndYL3A4NW1WZnFt?=
 =?utf-8?B?NCt5czU2YmRwamc3Vjc3ZW0vZlZ4R09kVnVlSkFlbEYxbmJNL3NqQlFUbWp1?=
 =?utf-8?B?RFNLZkgwRGxTUjFadTk5ZFlHb0dFdXNQcW1CTitmRktrM00xcThwRlVNTlBa?=
 =?utf-8?B?MUR6TU1qRUk5VE5NK0JxWUpNY1RKekMxbisxamZHMDhzR1libHZ5aUQ3Qlha?=
 =?utf-8?B?ZHZHWnlJMXphNUJnWm1RTVMzc2ZKR3FPbng3TzROR0NydHZBOGZIV1ZuNlNN?=
 =?utf-8?B?YndVUVRBZ2oweU9JTkVYbGZhd05CKzBxLy91WkV5ZmZ1QmMrNTdScElxVnBY?=
 =?utf-8?B?ZUpvc2l4YXphcGx3UXpaNEhRdk83a2FyR0FRbUJnTWlvTVJpV1dKc3ZQNi9t?=
 =?utf-8?B?TmJmUDRXdE4yOEMzSTVSYjd0VngyVmFLcDBiOHNId2VHME9OamUxcGNoZjIx?=
 =?utf-8?B?MU1KNWcyQzRlZ1hvbERJeURlanpVb3ZMam5jRDM5cjJ1KzNJb25BY0FDbWxU?=
 =?utf-8?B?c2hNbE0rSlU5b25keTVReWU2Z0xyNENGaU1rTVh0aitWcTl2anZJWG81QmxW?=
 =?utf-8?B?ZkF6cXJ3cmtIdjJQaXhYMzF3TzUxQ1MrSm1OYjl0NWJlaFM5YlArbHlpR0NM?=
 =?utf-8?B?VmFYSzE0cDlDN05sNHZPY25Vb1gvNGFLWFJtQW95VUd0aXFORmVvdVRwdkht?=
 =?utf-8?Q?CYnz6wMPYc8KFkrHAkhCAIo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d775375-8cb4-4fc9-def5-08dc85a721ad
X-MS-Exchange-CrossTenant-AuthSource: CO1PR01MB7370.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 21:33:25.1594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frie/ux3zzyMi1FMXLo2vFQeTygs9mH5WsFgI0QkQsjeMdqiF0I33B+fpdb3505h5Q8zhdYFKAqtqc3ZPoBuBH1DkEvSymAdVpU8dwfGjKnZgjUrMbP16PKxwNUyrdsc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR01MB8462

> +/* Context - lock must be held */
> +static int ras2_get_patrol_scrub_running(struct ras2_scrub_ctx *ras2_ctx,
> +					 bool *running)
> +{
> +	struct acpi_ras2_ps_shared_mem __iomem *ps_sm = (void *)
> +					ras2_ctx->pcc_subspace->pcc_comm_addr;
> +	int ret;
> +
> +	if (ras2_ctx->bg)
> +		*running = true;
> +
> +	ps_sm->common.set_capabilities[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
> +	ps_sm->params.patrol_scrub_command = RAS2_GET_PATROL_PARAMETERS;

Need to reset the address range (base and size). A user may have previously
called "Enable Background" where the code zeros out these parameters.
	ps_sm->params.requested_address_range[0] = ras2_ctx->base;
	ps_sm->params.requested_address_range[1] = ras2_ctx->size;


> +
> +	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
> +	if (ret) {
> +		dev_err(ras2_ctx->dev, "failed to read parameters\n");
> +		return ret;
> +	}
> +
> +	*running = ps_sm->params.flags & RAS2_PATROL_SCRUB_FLAG_SCRUBBER_RUNNING;
> +
> +	return 0;
> +}
> +
> +static int ras2_hw_scrub_write_rate(struct device *dev, u64 rate)
> +{
> +	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
> +	bool running;
> +	int ret;
> +
> +	guard(mutex)(&ras2_ctx->lock);
> +	ret = ras2_get_patrol_scrub_running(ras2_ctx, &running);
> +	if (ret)
> +		return ret;
> +
> +	if (running)
> +		return -EBUSY;


I suggest we do not check if the patrol scrub is running when we are merely
updating cached values. More importantly, if we had
previously wrote an invalid value (that is only invalidated by firmware
after
executing a command), then when we try to write a correct value,
this "ras2_get_patrol_scrub_running" check will always fail, therefore
preventing us from correcting our error.

> +
> +	if (rate < ras2_ctx->rate_min || rate > ras2_ctx->rate_max)
> +		return -EINVAL;
> +
> +	ras2_ctx->rate = rate;
> +
> +	return 0;
> +}
> +
> +static int ras2_hw_scrub_read_rate(struct device *dev, u64 *rate)
> +{
> +	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
> +
> +	*rate = ras2_ctx->rate;
> +
> +	return 0;
> +}
> +
> +static int ras2_hw_scrub_read_rate_avail(struct device *dev, u64 *min, u64 *max)
> +{
> +	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
> +
> +	*min = ras2_ctx->rate_min;
> +	*max = ras2_ctx->rate_max;
> +
> +	return 0;
> +}
> +
> +static int ras2_hw_scrub_read_range(struct device *dev, u64 *base, u64 *size)
> +{
> +	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
> +
> +	*base = ras2_ctx->base;
> +	*size = ras2_ctx->size;
> +
> +	return 0;
> +}
> +
> +static int ras2_hw_scrub_write_range(struct device *dev, u64 base, u64 size)
> +{
> +	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
> +	bool running;
> +	int ret;
> +
> +	guard(mutex)(&ras2_ctx->lock);
> +	ret = ras2_get_patrol_scrub_running(ras2_ctx, &running);
> +	if (ret)
> +		return ret;
> +
> +	if (running)
> +		return -EBUSY;

I suggest we do not check if the patrol scrub is running. See previous
comment above.

> +
> +	ras2_ctx->base = base;
> +	ras2_ctx->size = size;
> +
> +	return 0;
> +}
> +
> +static int ras2_hw_scrub_set_enabled_bg(struct device *dev, bool enable)
> +{
> +	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
> +	struct acpi_ras2_ps_shared_mem __iomem *ps_sm = (void *)
> +					ras2_ctx->pcc_subspace->pcc_comm_addr;
> +	int ret;
> +
> +	guard(mutex)(&ras2_ctx->lock);
> +	ps_sm->common.set_capabilities[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
> +	if (enable) {
> +		ps_sm->params.requested_address_range[0] = 0;
> +		ps_sm->params.requested_address_range[1] = 0;
> +		ps_sm->params.scrub_params_in &= ~RAS2_PATROL_SCRUB_RATE_IN_MASK;
> +		ps_sm->params.scrub_params_in |= FIELD_PREP(RAS2_PATROL_SCRUB_RATE_IN_MASK,
> +							    ras2_ctx->rate);
> +		ps_sm->params.patrol_scrub_command = RAS2_START_PATROL_SCRUBBER;
> +	} else {
> +		ps_sm->params.patrol_scrub_command = RAS2_STOP_PATROL_SCRUBBER;
> +	}
> +	ps_sm->params.scrub_params_in &= ~RAS2_PATROL_SCRUB_EN_BACKGROUND;
> +	ps_sm->params.scrub_params_in |= FIELD_PREP(RAS2_PATROL_SCRUB_EN_BACKGROUND,
> +						    enable);
> +
> +	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
> +	if (ret) {
> +		dev_err(ras2_ctx->dev, "%s: failed to enable(%d) background scrubbing\n",
> +			__func__, enable);
> +		return ret;
> +	}
> +	ras2_ctx->bg = true;
> +
> +	/* Update the cache to account for rounding of supplied parameters and similar */
> +	return ras2_update_patrol_scrub_params_cache(ras2_ctx);
> +}
> +
> +static int ras2_hw_scrub_get_enabled_bg(struct device *dev, bool *enabled)
> +{
> +	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
> +
> +	*enabled = ras2_ctx->bg;
> +
> +	return 0;
> +}
> +
> +static int ras2_hw_scrub_set_enabled_od(struct device *dev, bool enable)
> +{
> +	struct ras2_scrub_ctx *ras2_ctx = dev_get_drvdata(dev);
> +	struct acpi_ras2_ps_shared_mem __iomem *ps_sm = (void *)
> +					ras2_ctx->pcc_subspace->pcc_comm_addr;
> +	bool enabled;
> +	int ret;
> +
> +	guard(mutex)(&ras2_ctx->lock);
> +	ps_sm->common.set_capabilities[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
> +	if (enable) {
> +		if (!ras2_ctx->size) {
> +			dev_warn(ras2_ctx->dev,
> +				 "%s: Invalid requested address range, requested_address_range[0]=0x%llx "
> +				 "requested_address_range[1]=0x%llx\n", __func__,
> +				 ps_sm->params.requested_address_range[0],
> +				 ps_sm->params.requested_address_range[1]);
> +			return -ERANGE;
> +		}
> +		ret = ras2_get_patrol_scrub_running(ras2_ctx, &enabled);
> +		if (ret)
> +			return ret;
> +
> +		if (enabled)
> +			return 0;
> +
> +		ps_sm->params.scrub_params_in &= ~RAS2_PATROL_SCRUB_RATE_IN_MASK;
> +		ps_sm->params.scrub_params_in |= FIELD_PREP(RAS2_PATROL_SCRUB_RATE_IN_MASK,
> +							    ras2_ctx->rate);
> +		ps_sm->params.requested_address_range[0] = ras2_ctx->base;
> +		ps_sm->params.requested_address_range[1] = ras2_ctx->size;


We need to clear the RAS2_PATROL_SCRUB_EN_BACKGROUND bit in the input
parameters.
This is in case "Enable Background" was previously called, and this bit
was set.

		ps_sm->params.scrub_params_in &= ~RAS2_PATROL_SCRUB_EN_BACKGROUND;


> +		ps_sm->params.patrol_scrub_command = RAS2_START_PATROL_SCRUBBER;
> +	} else {
> +		ps_sm->params.patrol_scrub_command = RAS2_STOP_PATROL_SCRUBBER;
> +	}
> +
> +	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
> +	if (ret) {
> +		dev_err(ras2_ctx->dev, "failed to enable(%d) the demand scrubbing\n", enable);
> +		return ret;
> +	}
> +	ras2_ctx->bg = false;
> +
> +	return ras2_update_patrol_scrub_params_cache(ras2_ctx);
> +}




