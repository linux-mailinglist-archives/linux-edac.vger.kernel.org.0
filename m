Return-Path: <linux-edac+bounces-5711-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGe+Gg/0jWlw8wAAu9opvQ
	(envelope-from <linux-edac+bounces-5711-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 12 Feb 2026 16:38:55 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD35612F0C0
	for <lists+linux-edac@lfdr.de>; Thu, 12 Feb 2026 16:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5141D3007F73
	for <lists+linux-edac@lfdr.de>; Thu, 12 Feb 2026 15:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF83C21E0AD;
	Thu, 12 Feb 2026 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MDxP2DXL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A76hmwvq"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BD51F3B87;
	Thu, 12 Feb 2026 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770910658; cv=fail; b=elgt3ZUrE1idj4lLU/ytHJiqDEIwIVBVaj02qcQVaCfyrAzcbeMgRy/Qp3PoHUfTlHdZy9MtgiQwO0+7twO+pPSv/1FKWG04ejc1izigEfi+gJIkbfE0UWqZYzYN9+wAn4QIkvF1lLFfbhTFn1OG+ireEBkRMcmLqjJrZZa+dO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770910658; c=relaxed/simple;
	bh=TP0DHU8Ql4d1eEEs5+Ei5oxZzdDXe3pU9hWLcZR9UZo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jlgfNMZ6/iSbX7n5v+q6+xk92IkouLw+yT+XMky6sIvJGEzEYOLrzt9h5DFKp26SgZOj9lnBC9WKfQ5hHEp1C8bqP3yuTvxcWme9vEOv/5xqqtCv86iFQ9T9pggzQdzKoZRKuAFbiBRzFGCI3Igqhu0Gk1h5AwvVjCQL7cQBhBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MDxP2DXL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A76hmwvq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CEtwpQ334556;
	Thu, 12 Feb 2026 15:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nQxuEO7QJwn41xAOTDOKRHexe47Wi1PuVf0kf0/NoOk=; b=
	MDxP2DXLW+96iYhkEnkVKaJBLlrXdXdbE3rYQxHk1SjlmzEDqqndY79t8bASZeIk
	iWpsoULTT4d8SqG3DxjopCu+uLeYqmmx7y1kyNPPt2+Q0A1puis5HzRd3dPa51bl
	xApoe1gYMEBz9lwh+eRqG+uosAcYMdrp66kP3cuTleOnj3gklmnLeJetPgNNyg0p
	8gYjU4vM4QFLRvIHMkSYlcwoR839om6abexOR5KJvz1JIUldUeCDC5HYfco7+8UP
	0gmxD0n6AD/wvKngrVGnJbmJ+6GDEESGIh3BGI7ix2yrTzBgH8V9WWpiWH9snaZg
	yJfJuHkXHuI2cNVT3CApqg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c88fv3mdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Feb 2026 15:36:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61CEGFrh008598;
	Thu, 12 Feb 2026 15:36:58 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013006.outbound.protection.outlook.com [40.93.201.6])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c8237amrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Feb 2026 15:36:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zF0kAm2jA84XMViJrPYWfiY1ijSs4BvOaO/y3tD+4tveQldlIoOkwg35FcRwaWdJ8lD9ldUMXpOTJKUP4bR3+RVtjwhZ3DQMy6rsHzctMF3UIgEJkmJSDh1BXUCMLuOtZrVx+Ul81q0yvVuKEcufmczo8vo6jV/VTDBy7xkEQTkvDBDsdCHhWgSnd7jjTUpVd8VJFzhG9fDcYuJTYo4H6nKL9PqcwFo8mMaPEn4UT3DmGzwGgeuhQFeHN5HkCXQ6Pj8788NTUO4eCNTZzDY00GKaqs5nSzZI8eXrcHt61GmVGckfR+DH66izHjXuylSdQj9Qw+QViVa95TPF9KTlUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQxuEO7QJwn41xAOTDOKRHexe47Wi1PuVf0kf0/NoOk=;
 b=Dmwbop6apG7NFQ9Q1+DbHOFwYmwZN68teG0nLq4+9ILAF5NTwrBA6QWSQ0lc3lU72kEEDr59myS43nGp2IA3/PxdPiYb+l3w5/wjGEOyKeeWczXm1CKwgV8rY3llRuT1VdJ5dSbuvSTuL1omZE44a8Eo2bauIJrW7rAuzHRwYsLJnXRBrcAZ8TqRf4brONnD5KFJDeua+GZFGICqFRPvyeBZwjqc0DrA8+RDEhjFR8p89yLpc5hRmjONjb9wPvQexH3umvJrDKLvnYxlINjN4A8ucxyNxRFnfOaoIS1iIooltgT20L9uwGwHod1nN4l+boBOM3/fJBE5QCxF852gmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQxuEO7QJwn41xAOTDOKRHexe47Wi1PuVf0kf0/NoOk=;
 b=A76hmwvqVaDnGCa1kmmKPO/DXy7ZPT6jWj4XuTIbFjXTvmByXcQR7Nnde3sbNOce9lvnf6S9GiZvEicv1p0dG2WO1kv0632RZP3VMQaNM2ubQdJr7jLLpr1P/Yc1jSkTR0v+SqcjwI1AafqK0btsL3KlLuvrD+oE4cVjC9Wz62g=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH0PR10MB4828.namprd10.prod.outlook.com (2603:10b6:610:c8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 15:36:52 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 15:36:52 +0000
Message-ID: <09d2117b-02a2-4e16-8536-1d02e85ae6ee@oracle.com>
Date: Thu, 12 Feb 2026 16:36:47 +0100
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
Content-Language: en-US, fr
From: William Roche <william.roche@oracle.com>
In-Reply-To: <20260211163438.GA1637@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0286.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH0PR10MB4828:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec718f4-587c-4af4-a1bb-08de6a4c8b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEZBeTZkWFg3K3ErZ2Z6RGxuQWUvbkNQZ3Q0dTFzbXVRRjA1MkowNU5GOWRK?=
 =?utf-8?B?Wm03SmhmQmVCcHI2WGF1MkNlekl4SDNoWUhhbFJkR0gyU0cydXFodngrajlE?=
 =?utf-8?B?WGhqd0s4SjlkdERlem4xUFBUckdDTXBkUGtYU3A0SzJLWkhOK2VKU21jR1dR?=
 =?utf-8?B?bEFVSGN0Q252cnpzN2piNXIwdmFZeEJFRmNhbWdwTVdxa3N2azZjQUJWbDBB?=
 =?utf-8?B?aUhyclBwMW12dGhCVy9hVmwwajdiTFZvZ013RXI0MWE1UTRMeWRlbjdlY25k?=
 =?utf-8?B?Z2V2ekc3b2dBQno5b1lubzNmMVFpMFBuZzFXUEFKZjZmRUwwZWhWRFRjYUp2?=
 =?utf-8?B?T1JrYmJxOHlPemxwOEsrK0tGaUVpVlllVkZDMjNSekpmbGlhTzF3alpKQmZO?=
 =?utf-8?B?UDMyMDV6QWh5ZmY1QWIrOFVNMGUyaHk4cHBoSFRORmxTbEt3Rk9md2RmL2ZK?=
 =?utf-8?B?WmVwaGFTR0N4bTljSFNTbTdLVTZZbGh1UTRmdVFqS3lkbG5oa0dUTGJvVm1w?=
 =?utf-8?B?cnRMMytkNXFnSFJJUS93S01iODlLZXllYnZVMzJaaGYxN1Jqek5WbEhtQUpa?=
 =?utf-8?B?NGJFRDEzYWVrdENmdmV2YWkyamEzL2hOMDZGQ1ZFQUZIUExNNm9udk14N1JV?=
 =?utf-8?B?ZVUxLzZDVkhpYnR6U25mL2FsV1VTTWVXWldYazVWaXJ1ZExtOHkvS0ZxL2N3?=
 =?utf-8?B?STdWMTFBUW5ISXlrdW11UlNQcEcwZU5wbWNlb2IxTktQQkNDeUsrb0w1VTNl?=
 =?utf-8?B?RkU4WnlEa2ZxWjlYQXhZR28rSUZKTHpVa2x1N2o4aXZuditvRmYzd3VNN1hl?=
 =?utf-8?B?RmxNNEZQdkc5V0xvWnZ6eS81OE4ybFVKUko1TTR5M25SNEpmaERNZk1rZHgv?=
 =?utf-8?B?Wk5ka3o5QXBkMUhPNUtpMjlyVlg1K05wbUxWSm5BNmNjQVJlQ1pMOW9laktO?=
 =?utf-8?B?QmdjYlZGelZndGxoTHU5UWNIUW0wMjBIK3FONm4wVWt4RitnWk83RTZlalI1?=
 =?utf-8?B?TDM4dllkeUI2L3Q3NmdGWUNqRWtxSTFIaXBPbjV2dUh3ZlVqY21YcmFrNkZT?=
 =?utf-8?B?bWhZSWNMU3dBTFVicGo0c1BZd3lGa0tmbUVCVjBOUW1nNk96aFZVNW9Na1JM?=
 =?utf-8?B?RDVsMzhGNGloYzlaZ05mU1NHbkFXaGxBQmJuTTNuMStSd3NPOUV2Rk1HSHBl?=
 =?utf-8?B?bUtxbi9Oejd3dWlyM1NiTmE5MFE4Z0xFakhsWS94VkdrZlZjNnoxNlR1akIw?=
 =?utf-8?B?bkx4UDJvSm0xWVVpWmhHalZMNXJodXJiVnkxSks4Q3ZkVmhxZldqbVVTQXRo?=
 =?utf-8?B?WGVSeHluMXloRUY4Q3NTb1RDeWNzTlJWa21LNFc3UUZiUThvL3Z3anNDem9j?=
 =?utf-8?B?SUlzamhOa2V2b09pclIvcm5qZ281Z1JxcEhDNzZkaHVoZXVpNnQ4elRxdnlQ?=
 =?utf-8?B?dDdrNm9tall4cGVwL25xakpIVFNPQmRMNVFPNStZT24wcGZUaFdMNFBPZXNE?=
 =?utf-8?B?eFNMVlVJdExxbnh0alh0U2huMlRNRFJwYWhXYmVDak5LNFJDZkZrZlhhWlBp?=
 =?utf-8?B?cXpCQzB0UUVEZ2UzOG11OGl0MVZrYzlxL3ZLWVFFNDErSUcwbjAzR3lXcm9B?=
 =?utf-8?B?M1Zrbkw2cWJuc2FDN2ZnNjBDU0Z2Q2lHemRpN0p5V24xUDF5d2FDU21HTy9a?=
 =?utf-8?B?MlZHWjJlYU1Za0x6a2lXRzJuUWVjZklIdFM3QzNzTWpycmYzSWtEM2dFeXJI?=
 =?utf-8?B?MFNOd2I4Zk1pR2NWNE54WHl1Z2J2LzRHc0hyYk4wWDBVVkg1ajdEOHdmQXF1?=
 =?utf-8?B?VEx6clcwZSt6QUN1Vlg0T01WVlM5czdUL0tXTjZvVVBIZHNTVi9LVEViM25v?=
 =?utf-8?B?VmlVNUZJSTkxVXovYWVlN28wOWNPS1NYY2srdy9YWUUxaEZEYVl3RzdySmgv?=
 =?utf-8?B?WUU0UzJod3JEVWdOdlRNUlRFT1Z5N052akUyZ2k0VWx0elVNL3AxZit0bHRx?=
 =?utf-8?B?Rys0bXZrcktzVUhlUHRuaHdSd25sTXA3M1N1QzRuMFg4MTZVR1haWkJJY3ds?=
 =?utf-8?B?dEV0d1dZRTdCaEIvMUcvWitWNEY2Wi9BMm55Wmx5QmVyVkdPMm9ZblVkYUx2?=
 =?utf-8?Q?lPPE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkJmN0VIZlNDTk91RXFnRHJEeUVmaTR1N0NOcmVMSlptVWdBcUlPRVhTN2RD?=
 =?utf-8?B?cStaWldxNkhmYkozdldzZ1lDUjdJNitwMnlDTm1ib1FIams4bmVPS0N3OWUr?=
 =?utf-8?B?NEZsS3dKNHFlaHNkdHp3M290UjkrYmhDY053TXNxQTFvM2tJL05rNGMvTlNU?=
 =?utf-8?B?UmQ0NElCRWdGa2Jpdk92S0ZpU0dkWndrZ1Q4RTcvUDBWamIwYlBWSTVieWg2?=
 =?utf-8?B?ZGYxNitWZTFYenpHTXNsQk1qUUFpMVdqRkpBVWJXamdkeGxJL1B3SVJiSGRP?=
 =?utf-8?B?UERpOTJlTFNTa21wZ0FXVDZxbkt0TXZkRk51SXhiQSs4K3ZabEdlamYwMS9o?=
 =?utf-8?B?OVdZcGg4RlU4ZUZERDFmZjU2VDd6TTU1aDJ0ZlZ0dE9yTlVFU2FsbHJyMDJy?=
 =?utf-8?B?ZGplamluVlZDV2o1YXFiWDlQclRuOUpMNkI3UDBhOUdId3ptWVEzYzZtQ0xv?=
 =?utf-8?B?UnNKWmQwaHdNWmRWdGp3UUd5M0xHSWFreDdxT2Z3UUhTUXdqNk9TVThhV1Rp?=
 =?utf-8?B?N0RvTHVwN0NkbmpPcGxma2cvekNQSWdzdXFJRHpsV2dsQkg5U2oxUkxTcVQ2?=
 =?utf-8?B?ZFJlY2xuSlcvUHVRNTB0ejh4NG9wZ2hxUEVRMFZTZ3Q1cjhzc0MvV1kzdzBT?=
 =?utf-8?B?K1BDaUMvbFFFZ0pkSmFOMGpDak1rUmx0WEJXN0J1YXN3NDdHVDlTV2hzOUV2?=
 =?utf-8?B?US9PaHljL2JIL1k5V1hFQUFWKzJlREFIY0x3eWZCSHR1cGwvaU1UK1lSM0Iz?=
 =?utf-8?B?ZFVUdjgwd1JySzg4YnFUTVh6RnpUcDR6THRUcGFKaVVvemtFeFJicDltbG1V?=
 =?utf-8?B?UWdVRXgrdEtuZVRySVJZNXoycTFJNmVnaEM1NHl0eVZJYTZ1ZStjQkVwektj?=
 =?utf-8?B?U2FjUlE4aExNR203RFQ5a3JsZ3pVUHQrSGNxTE95RElmZXRxanZFU2hvRGlM?=
 =?utf-8?B?ZEJCRTY4T3MxNmpyQ0w0S3FLRFJpNG1SK0VPUVJZOVVBWkJ6Yk43ay9ZdTRK?=
 =?utf-8?B?MURzVTdiTERzdXhoYllMZjZ0MWwzOTBJTVQxdjVMaysxQVhPVXR2bkJFZEZh?=
 =?utf-8?B?dWRpODg0VzNONGZPWXN3Y050RnFZZFM2NXVtczkwdzE4RmNJdnNOV0RLaGh1?=
 =?utf-8?B?YWpiejBFU2h6Mm5VRW0zbmJaYUFIZDUvY1N0cDZCbUlzQTl1c2JsNDZ0c3Vk?=
 =?utf-8?B?c3d6cUYyOHBTa1B3MVVST3A2NDE2TkZMbVJ0YVozaC9YQ2pSbDlURmd0UEFt?=
 =?utf-8?B?cm41NkZmd01OeHNERkZ6QWFxR3dFZEZpdVhqRGdZNGlKWlVucjQ4QXNiZFE3?=
 =?utf-8?B?c3FIbjlSL1ZDNGlmTlpwTHlDaXEvMW1KWWtwZXNSSy9BaGdTdjhEYkIrM3Qx?=
 =?utf-8?B?SjR2VjUyMGJ2NXFmVURqOFZTdTRmV0s3clJFRk4zRDJMa3VBMWVpV0tyeWp2?=
 =?utf-8?B?dThFR0dJOUZnU3ZJYXBaWmtVU2Faa045dEU5YW5RWDRIWXIwanJsS0p6SW5C?=
 =?utf-8?B?RithZUtKMW01dU5yaUpOWlBjbzFiV2k4eXpVMUNhSnhwekdTYzE0YzVvc3dC?=
 =?utf-8?B?Y3dpNUJOVEFFckpkbytyS1p1am9IZkNRdWp5SzV3elR2QjRDaHNhU0xpZDZQ?=
 =?utf-8?B?YXFSaU94aW9Va1VPRW94VGFlVWh2Qis4b29jVnV1Nmkvd01wVU1tbWhkcWo2?=
 =?utf-8?B?TnUxaVF2d0NqemVBdEt3cERjMDQvaTYxUjRZYksrQWVnZWVZcDFQVUFWMFRD?=
 =?utf-8?B?dWVvVVVYamYrcVovdlVuUjgrajAzazZJNGxxWExScEdhTEl4VDVacW1wMDc1?=
 =?utf-8?B?Um83dmVXbHNVMnJnZk90TTRUdnRtUExoZHNHZXd3ZU5qSTg1UHJOeExrRENn?=
 =?utf-8?B?U1ZKaFE4Q01JdWh1aWl6QVpObW5sRDR4N3JmVDNWeUNOeHRmbVNwUWFQNERC?=
 =?utf-8?B?d0MwK3lFb3R3cHVGL05YUEUzSklFRmNVK2xpTkdKZmpSRVRrRmRvYWR3TEJW?=
 =?utf-8?B?UzJWYnAzQXZOdjJrVm9oK2FTdFF5RW9QTWFQSTRLellidG5QSHp3VUxyVnV0?=
 =?utf-8?B?ZzVjTlc2V3BVcHhOaFpZM0tKT0d5Vk13MUJkUVR2WFBaajZhWHpqajhXYW9z?=
 =?utf-8?B?UFh2MkZhWE0vSmNPakIxMHp5UEthTjd0VVNYV20xeWlCQXI1MGZlRGNlSGc5?=
 =?utf-8?B?QnZRcmZ4N096RnRJVFErVHVPcFl3ejB6Uk1QbS9EbWp6cTRwZlpyNVJBMmcv?=
 =?utf-8?B?bk9zQzY1d2g3TWZtTUdwUTlSemc0bm9wSU8yTmRtT0twY3ZOTGVacmJFWVYy?=
 =?utf-8?B?ZVY5S1QwUDE4WC9ZZ3JzVFpQSEVLVjR0SzJJZ2tvUTVyZ2dmdnhmK0cxU0tv?=
 =?utf-8?Q?p/o1zzfXOHmNKwz4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7bfecSGr9oOHcfSuQJO2IrDyhh2hgP/h1LtRt5zsSA2wxh7BUfI8GIlbTeQFg2kx/2AKVdEvIO7aETqfXazXqRGgLH3Spr3Xl/MH1RVSILOMq8F6eTRwkfjFeKNEqnn2EH+LQpRKSI2u4z6OSB8I0f1KTZJ8nR3TjRZwXC1aqh1MPSv0Id/umhntgtrjdPVWh8VLzcNfrc15VpiUoaYoPLkz8FRucw1eom9wkGmgg4xJNrGjBjO+HocPkPUHDSGi/dayin5LGbHel21zKdx3EbXsO/k4eaGzXEqGuJxTSVcXi+OXm8vL9P4d2dEAIKoo9X2lq4F3o0iCTi3oRG5Q2GtqjPVJaXJ9wql0WKPqUuWnTHqe8E/ZZbekf1/vv3K5jGJOYtMHX/hhGUMal03HbhRWDS3cZjArXzTwwex45byVPdW7QKGgYA4UgnbyNxBxrXYqtU2RaSPqX+hIg2gWsi5JxRF2RMBZbjjlTcoQ2CJz+tl57v5lqfrELfEgcQklpzPxSaoM9FlOXCs9TQaj/c9FYLdl2ZwIyHnZThshTRM/V7bsdQJVfUN4c4SkdoBVTnivloeipuokFjhdqe4nHKjkT0kvMn7ofFtaEtOgaxk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec718f4-587c-4af4-a1bb-08de6a4c8b76
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 15:36:52.6011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSohGyYfWnZyuuhZFYGOM52XlyOD+smBoiyvjSESKNZHRljlubEvT2muK7tVb1T5Qo1ZE/0vQ+uoxRrsWYINVbqvzI/H9Cvnipj1Wd2tY+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4828
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_04,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602120119
X-Proofpoint-ORIG-GUID: eAe5eee5-MDoMk6DsZIU3tFxl24aCNUC
X-Authority-Analysis: v=2.4 cv=Qchrf8bv c=1 sm=1 tr=0 ts=698df39a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=oJP--IJWeF5YIiizq8YA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: eAe5eee5-MDoMk6DsZIU3tFxl24aCNUC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDExOSBTYWx0ZWRfX9ucXmaG1pgVv
 5QFYxf7m4hPi8i3uyKzKjndvQb9eigbhNgc4I9UNZfIGGQaY8mswqumY08CKBwO9HmAHC1y+RLD
 Hz3mYF2zNvqLpViAKsBM/Y6cWMqK65/2O4Y2C7IFHUEWNlEaD1c+u40dg2CMvZSFzzEJN+8Bmw0
 ZUKnAr8lM2+r1VjfCgGrt7F/3ZsgtgtQ+Rzjbyw1/O9TVKcSUhaSWvMdvMEeykP1BzwRHac3j3T
 cJru3JzGrwIV3fAgnNJ0ARnZrLlsrw2qantjoHJX/rw+gDbeFIiPulJFwjxeMNeexRQDxFyl3Cm
 WmD/14fXF4OHQvlsOMFLlv06pBsVy20QfBG7H1PdRTomru25ozUxVDbw3HVXJHyoA1unPIv2Gx8
 sO4h+2tnH+ebKpOkH4ukN0Bum2iDn1caNkDzsaqC4QzSytCurRhUNRaopQsmxTutfIC7Ke77FjO
 4JMXpVNvocJDq7f/UWw==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5711-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[william.roche@oracle.com,linux-edac@vger.kernel.org];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[147.154.114.232:received,2603:10b6:610:12c::16:received,205.220.165.32:received];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BD35612F0C0
X-Rspamd-Action: no action

On 2/11/26 17:34, Yazen Ghannam wrote:
> On Wed, Feb 11, 2026 at 02:42:07AM +0100, William Roche wrote:
>> On 2/9/26 22:18, Yazen Ghannam wrote:
>>> On Mon, Feb 09, 2026 at 04:08:19PM -0500, Yazen Ghannam wrote:
>>> [...]
>>> Linux:
>>> arch/x86/kvm/x86.c : set_msr_mce()
>>>
>>> Please note the comment:
>>> "All CPUs allow writing 0 to MCi_STATUS MSRs to clear the MSR."
>>>
>>> We should include the MCA_DESTAT register range here.
>>>
>>> What do you think?
>>
>> But before trying to update the set_msr_mce() function, I don't think
>> that KVM keeps track of an MSR_AMD64_SMCA_MCx_DESTAT set of registers.
>> I can see mce_banks (for ctl, status, addr and misc) and mci_ctl2_banks
>> locations in struct kvm_vcpu_arch, but I don't see a location for SMCA
>> banks like MCA_DESTAT MSRs.
>>
>> So if we make kvm ignore this update instead of raising a #GP error,
>> would it be a valid solution ?
>>
> 
> Yes, I think so. And the details depend on how much of the platform
> needs to be emulated.
> 
> Some ideas in increasing order of complexity:
> 
> 1) Ignore this register write.
> 
> 2) Do a basic validity check.
>     Allow "write 0 to MCA_DESTAT" and #GP for any other value.
>     Don't need to save MCA_DESTAT values.
> 
> 3) Replicate the full platform behavior akin to MCi_STATUS.
>     Would need to save MCA_DESTAT values and do a "HWCR" bit check.
> 
> I really don't think we want #3. This would useful for "register-based
> error injection/simulation"r. But that use case wouldn't do much with the
> MCA_DESTAT register without all the related Deferred error interrupt
> infrastructure.
> 
> So I say the choice is between #1 and #2.


Thinking more about the problem introduced by your commit, I realized
that only SMCA systems have MCA_DESTAT registers. So we should not
allow access to this register from a non SMCA machine.
  And Qemu AMD VM is an example of a non SMCA machine !

So according to me, modifying the hypervisor kvm to allow the access
to MCA_DESTAT is clearly not the right move.

We probably should implement an entire SMCA stack for Qemu, but this
is another topic...
For the moment, Borislav Petklov was right when he said that kvm works
as advertised. The problem that your fix introduced is that is tries to
access SMCA only registers on non SMCA machine.

Do you agree on this aspect ?

If yes, than the correct change is to test if we are on an SMCA machine
before accessing this register, like:

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 3f1dda355307..8664ba048a62 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -875,14 +875,18 @@ void amd_clear_bank(struct mce *m)
  {
         amd_reset_thr_limit(m->bank);

-       /* Clear MCA_DESTAT for all deferred errors even those logged in 
MCA_STATUS. */
-       if (m->status & MCI_STATUS_DEFERRED)
-               mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
-
-       /* Don't clear MCA_STATUS if MCA_DESTAT was used exclusively. */
-       if (m->kflags & MCE_CHECK_DFR_REGS)
-               return;
+       if (mce_flags.smca) {
+               /*
+                * Clear MCA_DESTAT for all deferred errors even those
+                * logged in MCA_STATUS.
+                */
+               if (m->status & MCI_STATUS_DEFERRED)
+                       mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);

+               /* Don't clear MCA_STATUS if MCA_DESTAT was used 
exclusively. */
+               if (m->kflags & MCE_CHECK_DFR_REGS)
+                       return;
+       }
         mce_wrmsrq(mca_msr_reg(m->bank, MCA_STATUS), 0);
  }


I haven't noticed any obvious other non SMCA limitation in the other
changes of this series, but if you think about any other case, we can
probably fix all of them together.

If you agree with this change I can submit it as a formal PATCH.

Thanks in advance for your feedback.
William.



