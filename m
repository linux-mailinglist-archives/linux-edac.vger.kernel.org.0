Return-Path: <linux-edac+bounces-5715-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O4sHddXj2lqQQEAu9opvQ
	(envelope-from <linux-edac+bounces-5715-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Fri, 13 Feb 2026 17:56:55 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCF01386D6
	for <lists+linux-edac@lfdr.de>; Fri, 13 Feb 2026 17:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6214630071DE
	for <lists+linux-edac@lfdr.de>; Fri, 13 Feb 2026 16:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A7E32939F;
	Fri, 13 Feb 2026 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sPJimYo2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E0P7DryE"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7EB23D7E6;
	Fri, 13 Feb 2026 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771001769; cv=fail; b=lgJ/Rm/dja0p0ziaFkFVwpbJab0AysxOGw9yYkWWB3BspScoZXdNyUt2WTFTBAIFtWNZpoLeD5fPlCoayXHGZOxvpjUWRzAyH1kpFVT2cYPjNPm1MYhEidibIQwBregRIgJh4tnGqkWN6JfXI5vMyFCMF4xTgOPgdQcz1//auNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771001769; c=relaxed/simple;
	bh=GTxy8YrV+DRSJJqtIqHT+uCnI70l/u5J+x0AkOvbsXM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CXIqmIIBn6eS7wW4qKVmI0Russns0UwfJoBiNdITUVvGXoQwd5aYdJpX/e4Mpe/F8DuFGVf84pL6z8EbsOWgWxQK6YBlnnj/dXyR/sxEM2NtEjujo/unTnyZJVr0It1V0l9Ls2+3m0yJqpCUAEhMHexcQiNvZednXXVYkENRsHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sPJimYo2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E0P7DryE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61DDbh0m3491315;
	Fri, 13 Feb 2026 16:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kesMXID/BIZ/qb3sTFqSHe296sXisOompHggG5wkALc=; b=
	sPJimYo2ILCySoL1G8Bg5W829JQBTkLSs8Rwxl3FIF2ysi2amxxTYBXy+XtRayZY
	eiSPgjnABpSx3vPOgXYmyufia2CRPiZY1iF1Qbg2B6MvtdtmYKFjiQC4kIjugkrQ
	58PU6WCSUXCHyGiKT6FVh8B8DZIfA62dCC8xZa9g3Jo84BEe0gx+8RXbWkJIYN9X
	Dy8ffin28rOSofEBJCFP95XG0KtxuCMs7HObGQxPMhrGARN1Ohf/d40aMZ81u3kD
	k4ltBV0QGMprMMCH/lbSZMqKgo8qP3hLefRYHmKxg4tvFbxcLbKuAPJQgoLJvsyb
	9WFi9n4vy0PzUwN1ETHJJA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c7rxu6wk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Feb 2026 16:55:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61DF1ARO030021;
	Fri, 13 Feb 2026 16:55:33 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c822cjfdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Feb 2026 16:55:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOAZzPQkTEIT7gKnZT9rXoOA42M/CDQUVWV9qTr7MYUMNJqofnVayqykDwHpRE/4fVL8EL9/pGOAAL95loZOvabf/EyxYQ7IFRWfIpC0eNqj7z+3rZQJFBWtCqHIRAfB/MWfR3HALYJ/2WzqYLz9PePLocCg5Kqegbzntz1Xb+IJfz+A14FzC/n40FtsqUSOWhsIpE7PZbQ3tEl7rfZCSbO5Rw/8GOJgtRN6lYjGwFMnIQCy4d5/kN9X8zPYUpChYYl7uMoL5HvtRZXprEeFEUS/ZelQU4I77EdBP08LUGRKQ8rKJ97/S0jS5qxB74Djv3+HhMtfbVWor9I3HJv+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kesMXID/BIZ/qb3sTFqSHe296sXisOompHggG5wkALc=;
 b=B5uBw6p88wsSqgcT+E/YD/i5Pmm8/W0JKrKRe8csfvJ6P0HSpaFsKsMW1me3np966V2rEfp1DezsHCZyH5P80CNFR43p9EnKUOdOp7bh+kVmRQ61eMRkQmw4IjNKDfAFRe+FBVUcRcdyxq23P0YFVNHfteSuXSn1PLxkhiPraJOpFoOvAzyHYOxPtmGLQa1JILaPhr7bLTkazA3oewPB39GK0tZpgPMpeIZG5BG2tb0qoOyGROhuNWGCazu7iZLg7S/NiKSII/RftwvXGZiZPRr+oP5hGZcLrCoi1VQxw6HjNkDGemwi93i4J4U7geSUhPS3Us0pA06IQ3LrIXo+Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kesMXID/BIZ/qb3sTFqSHe296sXisOompHggG5wkALc=;
 b=E0P7DryEcmsCpr0EoNl0hk7UF1lBBAqlnlwheVpc5UHdk7c11lHb3Mthj91Ok8SOhE2BD7AdA3/2EdwQmveGlPkoIT/27HqgW7qT3B1PeG2XsOYRmByynswfWo2que6n/eoGptCZqgVVYovf3fEQ5rzaAquhOuJlo1L7ChpkyeM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM4PR10MB6837.namprd10.prod.outlook.com (2603:10b6:8:107::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 16:55:30 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 16:55:30 +0000
Message-ID: <c6ddad69-c87e-4665-a54b-4dc02c7045d5@oracle.com>
Date: Fri, 13 Feb 2026 17:55:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] AMD VM crashing on deferred memory error injection
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Tony Luck <tony.luck@intel.com>, bp@alien8.de,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        "Allen, John" <John.Allen@amd.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jane Chu <jane.chu@oracle.com>
References: <48d8e1c8-1eb9-49cc-8de8-78077f29c203@oracle.com>
 <20260209210819.GA445331@yaz-khff2.amd.com>
 <20260209211843.GA459737@yaz-khff2.amd.com>
 <6f87d29b-c30a-47f8-a519-0e1fba36f1a7@oracle.com>
 <20260211163438.GA1637@yaz-khff2.amd.com>
 <09d2117b-02a2-4e16-8536-1d02e85ae6ee@oracle.com>
 <20260212193058.GA315621@yaz-khff2.amd.com>
Content-Language: en-US, fr
From: William Roche <william.roche@oracle.com>
In-Reply-To: <20260212193058.GA315621@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0544.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM4PR10MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae7b704-3703-4f8c-2e19-08de6b20b219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blNaYVhzRlowSTU2TUJ0bEdKblQvdndnbFRYT2w2ZGtHbFpJZzZ3cjBEK3l3?=
 =?utf-8?B?SWhMT2dDTHptMHlzc3ZtaGNKTXBMUmh0enlwUWVxMC9sNHRYaXU0TmZlYkpO?=
 =?utf-8?B?S2t0QjF5YzZEMkpwb09BUndCMWo5ZmJZQUk1M3U2cXlncW5MUjJnY2dxUmRW?=
 =?utf-8?B?WjA3ekRCN3JoR2dkR0RJYTBETGlnWUxwd3RwNENpeE92M0I3ZmN1ZHZDZUpQ?=
 =?utf-8?B?RVBrdDF5T0dZVG1uK1lpQzdaa2dwRXFrTXpRRXQ4dkNMOHhmcHpkcWdyMUU0?=
 =?utf-8?B?Z1hrMjhRVXlBSnppdm81T1E0M1NWMnR5MlFiNS9qNDJpUVVtTHY0OVlNdlJW?=
 =?utf-8?B?Yzg2dU4wR1JKRXp1OTFYMzR6N3l2THVvV2tSQlZDRVdaSVVUME5TajNvSm9s?=
 =?utf-8?B?UWczTWZBbE9kS2NJMUo2RWxxZ0psQmxxTXZWbHpjSFhpaVh5bGNTSU51TEF5?=
 =?utf-8?B?ZFhUbzhTL3BvQzFZTmtub1FaUHIyWWJRWHN0TjJPZnhITkFSTmR5blpmQWdH?=
 =?utf-8?B?RXRsYmErbW5OTDRZM0VoSm8zT3FtKzZkTS91ZUlpQmZDRnRIVXVWU1BNSjBK?=
 =?utf-8?B?YXUrWVNITm0vT0JTUnMvdkoxNDdLUTRhNGZuL0JkYU1IUHlieTVkOSs4RUFC?=
 =?utf-8?B?a0JSUXRBb04zZy9DbUM2UFFWUFplL0YvdFFBMzRLeitUdHMxc2UrOHRrWHU0?=
 =?utf-8?B?amtjSGhoRTAwSEcrWUo1L29YbU0zazVGbTZlRnhyYnE3V2JueGFlNUFjd3Jw?=
 =?utf-8?B?dlg3bWp5QjZLKzhDN2FzbGNGRFRmRTZQOUIyeXhWNk5aUGNpaXlkUjFXc3Nk?=
 =?utf-8?B?empMSXJyWGZuK1VnMTJ0Z0tsZFNQQ2RIM3h2Zm5FZGZSV1NrMjN1OUhzMTFW?=
 =?utf-8?B?RnhsSmw1VDluc0JPc0RYZjcwakwyQmdrbDZKTE9Lb0g4eGYvU0ZETWxuN1BU?=
 =?utf-8?B?aVVOS2dhVDRJVnlhWGRSZDlQVjBjb2FOWk9UUDJ3NWFhRStFazRkeDRxbWtB?=
 =?utf-8?B?c2R4cURsU3JxZzkweEN0Ump5VnI1VEQ4Ymxpd0xHK0xuSVcyTDF0K2NHeDYv?=
 =?utf-8?B?ZE5vWWVoNFh0Y3RNTmFWQkVJOFBMMUZpYzlDTHFxM2IxWkFrZU4yZ0ZZQXoz?=
 =?utf-8?B?aXphYjVJQWNkTk1VaW80VnZ2WVpOTjhjQUhlZXIxTDdGT0E3ekVNY0xGR1d2?=
 =?utf-8?B?VnFKUVRSZWxheFBLeXp0RU53aTM2U1RYRWo3RFJPZGtjc3BEaWhiVzNEU3BS?=
 =?utf-8?B?UGNuY21DZzQ5UzVtajQwVU1aOEpGVGdGLytBMVdMYlNrSXZLT2xLai9oaDhP?=
 =?utf-8?B?SlczNjUrTGtGdW9HWUZnZGRsZjcwR0M1akpsZWdUYWQvUTVCL3NPbXhUNnBo?=
 =?utf-8?B?RlFPUEQ2QkIrbElzTzVrZlpKZVplNjZPRWNHREw0YVVhMURrNWo3eFhjQnZU?=
 =?utf-8?B?SUNkK0F1RmFpUVRVZTN0RWo0VG90TlVjVi92Z1cza2hqSlVOR2FNWWhmNCtp?=
 =?utf-8?B?MmRWOTZSaEdpNnVlS1lGU1ptZjFiMXlMWWZHb28wRml4amd2UWttaVAzK0Zr?=
 =?utf-8?B?dU9rcjUxaVVlRmU0NDl6RXVwRHFZb24rTDFOellYSGRCVFViWGpCWG5GTWRh?=
 =?utf-8?B?a0RuZnFpcVVleXN5WklZOVB0MFYvSHZoYytyMzl1M1d0L0lwa0F4YW1QcXU3?=
 =?utf-8?B?cEZ4NngvY2lITzNnYk51czhnelV1RlpIbnlHVlF5WnFjNjVsV01ETVQxV2Z1?=
 =?utf-8?B?M0pKbUVuV0VtV1Voa0EyTTlOemY2eUZZQ01iSG9ZSDlRU3JocGpxdjhybGl6?=
 =?utf-8?B?dFQvQzNTMVFRUnZ5WW43UmxPTkFKNDhMNTg3SDRVeE9qNVdaZUM5akVQNFpO?=
 =?utf-8?B?LzRLY3d1YklmMUJyeEVlanVxLzFaTTVlTDEzeDdnczFudWx3MXp5cm1mS3VI?=
 =?utf-8?B?U2pqVTh0cXppVDREUjdMWDVTMzdiZ09YUURKNHVLMnlYMFhXRnoyZXdkdm1y?=
 =?utf-8?B?MC9OOG5qN2VlTkx3Tkk1RmE0RHlTRTBRVzl4VVlqaERsQ1V6Ync2cU1jOTlV?=
 =?utf-8?B?Ulo0M3VGRzlEMDg2MGx4K1ZkR1FEUmdEbEY1VklhRVQveGdPM3BjOHNoRWlU?=
 =?utf-8?Q?R73Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UThJVkpDRURXeGxTOVBOeGpzNk5NVmtEcVlscURsa25jZHROeVlGbTZPZ2Vm?=
 =?utf-8?B?VkFudjVhSlB5cjhRVjJ6anl6em5MVGVWQUZ4RHo3dUlNQ1FaSkVHbUYya2dN?=
 =?utf-8?B?RkhRcHpBZ2QvU1dzYlJPbjg5dHV4TWJQaTNmVDcvem1FbjlKaW0xb2Y0NUM5?=
 =?utf-8?B?VkFEM0pOVTM3M3puYlA3VW04STdKMlppaXlQVDNXNmx2MTRoQnlFcjJxb3Vx?=
 =?utf-8?B?d3grd2FZSVl6TFVQOTRXMHBQSUVhRC9RMFNOSE9Pa2NTOVhsZURzbkkxVjBU?=
 =?utf-8?B?aEk5TGYwb0RGV0FRVGhjWmtnVjNCb1htb0I0QVVHdHlyQStFYjc3MTcyR1pG?=
 =?utf-8?B?eWNuSTMvWU8wSGRjbTNwTmhqZ01TM242aENjOU5QUXVMM0QyZjc4Z2VOYmFH?=
 =?utf-8?B?cENYcmNTeG4xMGNObC94bVdzaCs3bU90SkYzMk8wdHA0MW9xT2dMaEg2YnFm?=
 =?utf-8?B?WHBWU0loU0ZYMFEycVJhU1MzR2VSYlpPMnF5SXFwSGFEMlN0bU96K012M0tN?=
 =?utf-8?B?dW9WTEZGYkRRNVhPOGlsRSs2cDFHdXpDelk2cE1TWGgxOWhTZkc2ZWVHN2Iw?=
 =?utf-8?B?SVUxUTlTZ09oQ21GVkhuaFNxVk5oek5Qc2Z4ZWtEYXd6RnBsZmk0d2pBME5r?=
 =?utf-8?B?NHVzODF1eUZEUUtRUlBVdU9LSHVWRitobEREYkkyRGxKQnRGa2Q0N3N3RytL?=
 =?utf-8?B?c1lkTUoyM29PcjBIbVMyR3Z5UkhUU2pLRjNKQnhNbURIeXJBK0tMOENlNHBz?=
 =?utf-8?B?LzlxaS9pQkEyYi8rRHV1VmdMcGJ1Tmp2V0xHRmlndFkzVVR3dVVXc3JZY0I2?=
 =?utf-8?B?bHduMjZpQStmQ1RqMDRNQllaWEZQSG9Bb0JIaWN2Y0Z6ZER5MDZBOTBTTCtS?=
 =?utf-8?B?Ym96cy9CcUt4U3c1d3hqVTJYcitESWY2bzZ1TmhRVUNwT0FHS05oYVFkUEpl?=
 =?utf-8?B?WU10ZHpsL29JZjRQWUNkQllKOEZOVVB2Y0IxWFJETVMzSmRKU3VHU0pOamhS?=
 =?utf-8?B?Z3RQQm9jcG9tWFJxdWhPREZWUlJzaEpxclB1WjZyeUYvL2dQN2o5YnFnZ0hy?=
 =?utf-8?B?UkpiNEp5VDFTdFRSTTVZbmpwRERjZ01meG9vNzdTbG41c2NOMFlIZVpVYVI2?=
 =?utf-8?B?UWhiSXMvWWs5WEtMZFE0S3BGNFRSNWN3SVBHWHUwTTEwVENOQTJRb0F2Q2pT?=
 =?utf-8?B?TUMyVE9JOVhBMnM1MFEwZEhYUThzeEtMVXQxMk9xdVBaNFpiV2FyQWdqK0VD?=
 =?utf-8?B?U1JnbWJoeUFkeUwra3BYVXdPUkEwZ29ZMHRmci9kVWNqdTJwNC9jOEZFeFl4?=
 =?utf-8?B?U2tFdGFNbzBQNys0ekpjUGlBZE15ME1OdWpMRXRnc2czcUZRVHdnTHpobGxK?=
 =?utf-8?B?M1h1SnRTWWg1akhCSHQ2Y3RFNGdva2dpc1Q5NnV4bmRhVmJEQlcydEh5S3Vj?=
 =?utf-8?B?Qy85Wk55Mi91OEZnQitCOVNnZThtc1ZwRE9TSWdZWEpkTDhNeVlOekNUQXJE?=
 =?utf-8?B?TS90WG5tSUVKTkNOek0yaU15R1ByS1dJVkVIbkhuOXBsaW5aWWd5akZiVUdl?=
 =?utf-8?B?VkhWZnM1Y0tJMkI1TXpkRU10MlNCRUhmdEgveXgyZWZlVmdkbzU3Yy9HUlFK?=
 =?utf-8?B?SnZFZnNiYkJqaVNYOVF6SGg3MkgxQUhTV2wwbEV2dk1rY2RKOTdoWmtNWjhY?=
 =?utf-8?B?VnBhUzNocjRGVVBwNHpJcG5VVlVtbXhBdW5FMWhRY3pDa21lVGlyWTJHRThG?=
 =?utf-8?B?ZUVKaExwMzA3dlh4aEx0aUZ4L3VFWjZtM1l0NnhOL2FlakNtM3AwRytuSGdh?=
 =?utf-8?B?OW1UWFk3WUNKNXIrajZMUjc4MDVNaENqUis1M0pqbGpYSXppWktyR3RKN0kx?=
 =?utf-8?B?QzFpaHZuM2kxTUoyUWJMQVFSS3JvUWtuNno1dExYTDViS29rMDkrejRVN21Y?=
 =?utf-8?B?MGpPS1o5QmRTV0pRN3dJTCtrQkR0R2g2cDZjRXNRUVk2djkzWXhDSHpodDBj?=
 =?utf-8?B?ZTV1aXBNMGZJVXNxVnY5ZFFFT29NSDdMaUxYTC9iTTJBNGlmRWxYM0l4Vk5Q?=
 =?utf-8?B?UjFXMDZ0cTdoK0F5UUVjL0xCR2MwM1BycUNhLzAyb0UwRE9XM2dHaGh4T2gr?=
 =?utf-8?B?SHVMR3VpZXh3RWxXTnpzSXhaUEEzNnZ3d3ptS2RxenV6MTVnS010aUIzRmdU?=
 =?utf-8?B?QUdrQ2p5VHdDQy9kVkVhUVY4Y3A4MFlSNVkrUUM5cVROK3BEQVlGbC83WE9C?=
 =?utf-8?B?ZUF2dzRwYkR4QWt2eGRpdUN6ZDVZR0Y1RDVkb0VnK29uTno2YnJQSzA0SFZS?=
 =?utf-8?B?S0hCaHE0NEoxY1BGUll6YkJpVTV6QUU4MXhnNlhUSzAvdUF2M3Nnc1BlTVNJ?=
 =?utf-8?Q?N8RY/Rh3ureNHlTs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xPkI81tZ9JYxFIgTBi7RINTJHJPv4han5z78PGDFd4CWMwEKo8oZTkYMesUQ2Wkxpc0/QtaKRueIZ7lpRTm5XctAwVwN0ds0CLhCuE+kzJMrUkDII9GfpxUWs2j/W41iMz+nDA/RiH7gbbsUaJO8SxiRzFz6/v57HOQBimhhACfelPVauOgvTtJhR5fH+FP21NI2bHCN/txc6Gg2Bu+APnNLkfrW38orsh2IY1eyK+zj6Q9oBQ9dgbNmA6eU/9xqu3OjpvYQT4F0dkqreAZsedGkDkFLnOGsEo6AfFVRVCwf3zlsrJBSQp0YslRH2JjjR/sAAX0OhfrCorEwbi3iCA0YHAHNQnhJUDxalpV0GAzCqI0k6jVtLiQaGg2mp5ajLL1yYikf991f9JRQKLVUt3Hqa1gHqlrCizDY6D9sZsuDco4U3ATDDc7qJm4Ii94PQyo/u+CCJgLseNNq6DlkwgQoJTP/ChXlabgYFB/uDh8TTMwP13winW3IRWYhmOGtpiz7FFOgU6aa3A0HVnT4EEzlm/qnRM43+7bo8g3u8euBVKUOEWXGjs+8RVEv3xEkqBTHD7kmlNhtN7Tei8OahslHYdcaCu0hgiBkAj0Ucr0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae7b704-3703-4f8c-2e19-08de6b20b219
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 16:55:30.5727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tn/0uXodYtPGYbSKOVE+g1kBBkgn0aoG841YrmoSwf4poqsxZo7jB8Y3op11N+xjIfsW74YLddIbCdyW5pSR7veblBMHUGGahpsEII5C60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6837
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602130130
X-Proofpoint-GUID: 4gyVaZYtIHwdAnuB0NonpsyodWukI1Sg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDEzMCBTYWx0ZWRfX07wQ26gvI2qu
 CxzLcGlP2NZkY4dyAXdqvSsj1zwPuq3nklBwjI4+vullyV4kU0tMZJiOmwTafP/zjVbsfYZ87YA
 eEmPKbwLb9UP3yZXvuGrWar93uiInrxz62FTEPqMlt4/e5J3l3AXBCJcFBWh15etZUqkXQfOHi6
 wmcnMGjSkKTUzj0/3uWDosZnELESZhtGV7lhreC1UzSrFSA4pxm3TvCU348sLHZ5Gs6V68GErQp
 KUuj0B1FPtxG9P6iaCM6nahNhRrXnVvBcCvZ4zlZR5CWiKGp+IUXY8ocH3e4B/JpFGwu4i2m9M+
 H8csLEDZ2D+cFQdwR6A9UHIoujIvI4CF36bAkKUAJj5bq2nJ3i/3aS7ur6k8O/juMUncm9yl/XU
 NoRTrL7rQXoBHkxMSC1v2ARyZZfecgiEX5MVhaxvTkT18yDG1PR3jhlk77YtUcxRWRA6IuOsUWI
 twOtnElmPFXXqztJ0vA==
X-Proofpoint-ORIG-GUID: 4gyVaZYtIHwdAnuB0NonpsyodWukI1Sg
X-Authority-Analysis: v=2.4 cv=Y6f1cxeN c=1 sm=1 tr=0 ts=698f5786 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=zd2uoN0lAAAA:8 a=X_ur3aCBNmNBDOs4YBIA:9 a=QEXdDO2ut3YA:10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[linux-edac];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[william.roche@oracle.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5715-lists,linux-edac=lfdr.de];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CBCF01386D6
X-Rspamd-Action: no action

On 2/12/26 20:30, Yazen Ghannam wrote:
> On Thu, Feb 12, 2026 at 04:36:47PM +0100, William Roche wrote:
>> [...]
>> Thinking more about the problem introduced by your commit, I realized
>> that only SMCA systems have MCA_DESTAT registers. So we should not
>> allow access to this register from a non SMCA machine.
>>   And Qemu AMD VM is an example of a non SMCA machine !
>>
> 
> So the SMCA CPUID bit is not advertised in this model?

No it's not advertised -- only succor and overflow-recov.
As implemented by John Allen to support relaying deferred errors:
https://lore.kernel.org/qemu-devel/20240603193622.47156-1-john.allen@amd.com/


>> So according to me, modifying the hypervisor kvm to allow the access
>> to MCA_DESTAT is clearly not the right move.
>>
>> We probably should implement an entire SMCA stack for Qemu, but this
>> is another topic...
>> For the moment, Borislav Petklov was right when he said that kvm works
>> as advertised. The problem that your fix introduced is that is tries to
>> access SMCA only registers on non SMCA machine.
>>
>> Do you agree on this aspect ?
>>
> 
> Yes, I agree.

Thanks


> AMD systems generally have a Read-as-Zero/Writes-Ignored behavior when
> accessing unimplemented MCA registers. But this requires the system to
> recognize the register space.
> 
> In this case, the register space is totally unknown to the system, so it
> responds with a #GP.

I understand what you mean about the platform permissiveness. This could
be a valid change of the kvm layer, allowing kernel code that would
mistakenly access SMCA registers on non-SMCA virtual machine not to
panic. Of course if all AMD hardware would work like that, I agree that
aligning the virtual AMD platforms should be done -- but as you
indicated, recognizing the register space to consider for
Read-as-Zero/Writes-Ignored is still unclear (to me).
Even if we manage to do that for an updated KVM layer, a non-SMCA VM
running on top of an older host kvm layer would still panic if its
kernel accesses SMCA registers. So I'm convinced that making sure the
AMD kernel accessing SMCA registers only on SMCA machines is the best
approach.

> 
>> If yes, than the correct change is to test if we are on an SMCA machine
>> before accessing this register, like:

I'm preparing a PATCH proposal to submit in a moment.

>>
>> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
>> index 3f1dda355307..8664ba048a62 100644
>> --- a/arch/x86/kernel/cpu/mce/amd.c
>> +++ b/arch/x86/kernel/cpu/mce/amd.c
>> @@ -875,14 +875,18 @@ void amd_clear_bank(struct mce *m)
>>   {
>>          amd_reset_thr_limit(m->bank);
>>
>> -       /* Clear MCA_DESTAT for all deferred errors even those logged in
>> MCA_STATUS. */
>> -       if (m->status & MCI_STATUS_DEFERRED)
>> -               mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
>> -
>> -       /* Don't clear MCA_STATUS if MCA_DESTAT was used exclusively. */
>> -       if (m->kflags & MCE_CHECK_DFR_REGS)
>> -               return;
>> +       if (mce_flags.smca) {
>> +               /*
>> +                * Clear MCA_DESTAT for all deferred errors even those
>> +                * logged in MCA_STATUS.
>> +                */
>> +               if (m->status & MCI_STATUS_DEFERRED)
>> +                       mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
>>
>> +               /* Don't clear MCA_STATUS if MCA_DESTAT was used
>> exclusively. */
>> +               if (m->kflags & MCE_CHECK_DFR_REGS)
>> +                       return;
>> +       }
>>          mce_wrmsrq(mca_msr_reg(m->bank, MCA_STATUS), 0);
>>   }
>>
>>
>> I haven't noticed any obvious other non SMCA limitation in the other
>> changes of this series, but if you think about any other case, we can
>> probably fix all of them together.
>>
>> If you agree with this change I can submit it as a formal PATCH.
>>
> 
> I think this change is fair. It could be minimized further by adding the
> SMCA check to the status bit check for the WRMSR step.
> 
> 	if (mce_flags.smca && (m->status & MCI_STATUS_DEFERRED))
> 		mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);


Yes this is the minimal fix in our case, but I think that more clearly
separating the SMCA operations better shows the differences between SMCA
and non-SMCA.

I'll copy you on the PATCH proposal, maybe you can review it.

Thanks again for your detailed feedback.

Best regards,
William.

