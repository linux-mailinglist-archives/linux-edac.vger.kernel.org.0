Return-Path: <linux-edac+bounces-4790-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0E0B51F1B
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 19:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3760D1B26246
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 17:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5E332ED44;
	Wed, 10 Sep 2025 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vLW/YJpD"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724B025B1C7;
	Wed, 10 Sep 2025 17:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757525932; cv=fail; b=IKYdoByHAch5X4SeEhekQ66B8aZhtIDgVDGmspGp+PE3bQcqbRG03COT6nhSZDEd6op+EUlLHkKdWvXjaSImzDep/l5n3EK2G2tIoMMlTR++/MOBHlqzEVuiQP72bz9pq+kgCNwrm7kQvhj2PSYeLwbLiHWMtY/Y/gVJhtGAbuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757525932; c=relaxed/simple;
	bh=ePkk1nYZrVlqYbkB6HHZNHKuIOh1m/EnIXYPsO6FjbM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L9KL+wBFLSsBrUXZD9DNlxUMPKkE66T9Majky1pazoprsiANq1oIxYcdN2NIb4jECIEHZIH+S6VKoN9KaleXaBl9JCY0cQz0b0wDpUp5FUKQuWRI6R/wHvMEZg4LXhUbNKkYlUVZ7NwntBkWVqImY+BTkH8Da1kS06HjKjE3+x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vLW/YJpD; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=parHGsLchiQ1eTo7QYgdP6qIR1Fa13zVRbSHn2fQKT60YCx50aiK9rOJSjIu/KWX6tEz6tjfGSJZU0hy6ABgpeFu9/rwE6Y02GOWYtS974n3bv1GQTzc5jkV+LRJm4+mmll4L7+VEwxEssK0cu1QMIfsDDnGhsM98murvMMHK5t1ybatOj8dPCQS9U1EE1v1ijn5iTezBwLnjZWIx5L54QHSXzpHQn/H2yqWhoR13AiobfsTDj4pOgxezFMS2cgg+Px3C7M6oSDnzFfb5ZK+X/bUkaqAkC67sZlp16kBCAxz6mYb4yd9BcxXGe+L3TK3atP+rGGpULttFUeB2IbXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9hZIgcKrAwOu5wN/bV7p/mi6kXrLG4M/GOB/YxoJMQ=;
 b=vVLQNQmT6QezECm7mEbbO3BwugVGXcxykVfGHv3PrVKqIvtjC2OTJIjXEvCalsxstyqeZQeMB+YnZ0L6vNhwPwo8uXRFqyXsDpClQL9uLMLgvFuvNltNjoimvc5VpvH4eo9NZ2G6Tt3VTzkB0bPAzS/r/1LIVLnsWl1ROLYnuGai26uyN6eRUPYwnLND2PhqXdhcxFW0Fr4HqTZykLVCejK1zGNFQOCbvg2ZnakMDf/fCNuaQhPo2id6nFwQ2QY1RjQvSeojdQBwPjDF7B4FJ1MvpXhHcgn4OGiNJXYRlDK8vABc8HTFxDCHjKcrtOMtviL2Iysp8eiIqdVGIVpAFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9hZIgcKrAwOu5wN/bV7p/mi6kXrLG4M/GOB/YxoJMQ=;
 b=vLW/YJpDiWnbhSqOXVIEBHbkz47yuexNANiqT+ao5xxLjudc2nDfSMSpMcJlBZGVK/GUc9e8MeUC45OlZNZz7iEpL3aRit9HxgrKBRB6m3UL38Kybs8HZocuJSFexMeexGFHHX3zJqKpP4TqNVm4BDmanifjhapE1W2xKifRGHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by DS0PR12MB7947.namprd12.prod.outlook.com (2603:10b6:8:150::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 17:38:47 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 17:38:46 +0000
Message-ID: <ba326dbd-5216-4294-b645-c4ff2a2f6578@amd.com>
Date: Wed, 10 Sep 2025 12:38:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] EDAC/mc_sysfs: Begin deprecating legacy sysfs EDAC
 interface
To: Yazen Ghannam <yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org
References: <20250909185748.1621098-1-avadhut.naik@amd.com>
 <20250909185748.1621098-6-avadhut.naik@amd.com>
 <20250910152427.GH11602@yaz-khff2.amd.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20250910152427.GH11602@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:806:20::13) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|DS0PR12MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: 528bc71a-03ed-47eb-1ad7-08ddf090e4d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmtuaC80ZHB6WW9qYzBJTGJDcE1ZTVNsWld1RHVVSURrR2loNFFTTGNtMG1P?=
 =?utf-8?B?UDhJYzl3ZFlkV1YyUXdwVnBsc29zWVpVUVQySWZ0Z3ViVm9EUE4ybXg3a0tM?=
 =?utf-8?B?NlVZNG01eDdURHE5WFJLai9rQ3dka3c5eFVLakJaMTBzV2FtQWRRZDBNVUxl?=
 =?utf-8?B?YmUzQkhDbjZTK0o3ZzVlUjVQNkplb3lnMjZQYjNYamdSRkR4cEpnblRPZWRS?=
 =?utf-8?B?TWY3c010cTlHRnlQUVNGTG5ZTDgwM1ltdGs4emdWNlBGaDJpa1FOMDFOMXp6?=
 =?utf-8?B?bnNuTjRWZU9vU09LNjRjWXNMMmZGWnRkeXVmdUwxNXpiUnZJbEpzT21XOTJl?=
 =?utf-8?B?cmhDc0lMcTkydlBJZkVMSGhhVG5scDZkbFA0WmtiYURsR0cvWnpzRitBOWpw?=
 =?utf-8?B?RDgwZHVoYzRkTmEyTGpvbzJtY1pocHVESTRSdTZEQUc5czQ0UkpLb2tRR29y?=
 =?utf-8?B?YUdYM3B1akhqVjMxWXVsOGMyQmFQUGlUMnJBSC9ZOHlhVXlVcHFhUUdKVnRS?=
 =?utf-8?B?OGZ3OEVpWGRsajFqSjVNakloYWx5dGJUcUp0RUlwNzcweStWK2d1dE1tZnp6?=
 =?utf-8?B?RmhUbzNaM0Q4R0ZYeExFdjE5RTdGSnkvQWRuN1B3UGdrNVB2NElvN0JoaFhD?=
 =?utf-8?B?VzNvOTArMWgxblM5dHoxeHZwN09nVXllNmk4UElkRkErN2FIcDA0MGdDRGNO?=
 =?utf-8?B?RWI2cUlycHdTYU9tSS9RcWdxdzNIRXdoM1piZGhpbUhXMWhNMjZzTUdKYzhL?=
 =?utf-8?B?NURBbnZ0RzY3dVl3YkZJNUN3Wm9IeDJnR1NxQWtGcXNWRmpDTzJjVXA1bkZR?=
 =?utf-8?B?S001VXBLTFRBTGUwRXJSUW92VWhZOFpBWXZTNENQNkpVbUt6ZTZmTmdGZmdT?=
 =?utf-8?B?ejkrUm9Jd1daS0lGekpLTDZyRnduNkJkZVUyeEJmWGhOOGhrc3RaeHB1Ni9r?=
 =?utf-8?B?Q3FIMThVZ0gyUjlIMEZ1YnRta1RvY0puTjQwVHFWZU03R0JwRDVwajBZVTVj?=
 =?utf-8?B?ditNaXQzUVg2QWVleUcvN1dzanZpbndFZ3diOHFpa1JtbTdpWnlPUU5XTEww?=
 =?utf-8?B?Zk9BMit2VXVtMUJmK0lvbG4xRzJtOVVzNUtRWXJUV2tiQjE1RUo1VTdadlJQ?=
 =?utf-8?B?enYzcEh1SU8rVXZneUZEbVY5NTFmbkFOUG9ZelVMM2xEd3NTaTRudm9XUnJ1?=
 =?utf-8?B?TWxpL0lNblRuWHZ3WG5pSklVV1VpdFBSNjdnZzVjc21JV3UwSEdPRENoaEI1?=
 =?utf-8?B?anZocUdIZGdwb2lLTTR0b1B5SmgzdVgwUVJ6THFDdGVnb3ZnVitjUy9nQXNk?=
 =?utf-8?B?WTZOVUFDd0Q1V0k3eEZxd3JCV3hIejF6bElGT3FQSEJ3SjJhajFYNWQzRm55?=
 =?utf-8?B?eFFUaS8zNDRKM2dHclVucGhQTVhNMWdhZGxqcWQyVVQ3djdpOVBjRWRkL0E1?=
 =?utf-8?B?MlEvSy93dGpZdnFLcXArMDdyRnJLYnFNSzVvM01hSlR4S1pFQ2tuVEt2Q1FD?=
 =?utf-8?B?WmQxeDh2QjRXbGttYVBXTUxxd1ovSTlPMy95SWxVRUtlYm9ZSWtRNEF3VmJy?=
 =?utf-8?B?ek9PcG83Vjh4dmlKeTBTKzRvMDVyemtPUEV0RWZjNUlRejRGL3A4bGJad2VO?=
 =?utf-8?B?TnVzSVpwUVRHNHk5enlhSkNyK0dGQVJvNVlWTFJoWXpxMmZKbHArNE01RHFV?=
 =?utf-8?B?Q2NNV2lWd1lKU1BwakF4cnRFSExJTHNiWnJyOGhPWCtoWkIxSnc0QXBRUEo0?=
 =?utf-8?B?NS93WWdJRHMxOWR6MkdZM1pUaDE3YkVXY1Y3K0JmczdTYjJrU0NUUzk4R0dZ?=
 =?utf-8?B?clEwaUdiQ0RnUTJselBZUG1XVXRqMkYwVlM2N1pUM3NTMjZJVjRwM3I1M09l?=
 =?utf-8?B?Y2J0TVMxazV3YU1GUnBnazRGZzRkSjM3VFhaTys3V3FkazF6YXVRclB3VmlC?=
 =?utf-8?Q?cGwO8E0njs8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXFEWU1rRmJmbEU4OXpGWGcxL21VdklSb3RjakR0M0cvVWF4YXl2ak1nYllh?=
 =?utf-8?B?b0FLT1dXTDl2MHp2SG43RTFvaXdjcnB1RDhqRkVPRitKU1ljcVBjU3RycHdF?=
 =?utf-8?B?TkRjUjdQSGFURDAwaEphYzA1bG43ajd6V215bXFnKzdsNHF1NE9sUFl4Y3Jm?=
 =?utf-8?B?MjFjL0FUcjNHRTN1c0dIRUJKcFp5aWFZYVlIRlpxL1dsTytyK1RVZ3VSSDNz?=
 =?utf-8?B?bzU3NERBNlZhWmNuUVNGRjEzQkwzYmpFKzRkeU15MUJjMUova2V6dFd3UW85?=
 =?utf-8?B?TXRLRnZ3bjdoc0dicWFGN2pkQXd3azMwbk81QnZIS3EzK1pQZnJpT0RMZUVm?=
 =?utf-8?B?elFyTWM4YVJ6TmdtNVZ5eWE3SVROclVuNmEwR0hqZGtsQm9jeFVqMG9qYmhU?=
 =?utf-8?B?aVhScDI3bVRZY2JtanF4dVJxYloreERnVldTN1d2cjBWdFNBaFppODY5NllC?=
 =?utf-8?B?ZGdldGdYVG15YXlnUnp6SG1GOHZjazBqSXdPRjB2aDdXS3F0NmVuSEJNelNx?=
 =?utf-8?B?UG8wWjdqUmVDMS9KWXI2MWtaRHB3SXlUc0VDN2tXZFhEMTJjTTNwenl2NUlP?=
 =?utf-8?B?ZmE2REg1TDBYSG4vSEdzbE1OeFpEdWo3SDI5V2FMbVpMWHdxT3g1Mk1Uc1pG?=
 =?utf-8?B?OGNZVlNkM3hWQWVobHROK05NTVorMjAxbzNpOHd5WW1EOC9RaUk2bFlNWDNM?=
 =?utf-8?B?Z1diNisyay9HSThodG04OVFYaVpqS0hkR2lZV2QyK3cxSHpKK0dLUWpHeWZk?=
 =?utf-8?B?NDM4Qm15T2FDY3p6MmVXR3pBNERGb0Z4MUN4TkJlOFgwcFZjWDUwRFNTUTZ1?=
 =?utf-8?B?K240ejVvOFNob08zb1VxcmI0emJzQ2RiazAzMy91VmVTL1QwQ3BCSFlsbFBC?=
 =?utf-8?B?cnFRb28vL29Ib2xqNElyajk3V3h6b0c4YmxWdnFlQUx3SEJZUjJPb3JtaHZp?=
 =?utf-8?B?b3dicklJRzg4UDhVMXF2RUl6ODEvSG5IMkFZYkVNRnRlaVhtR2tnSGtxdWVi?=
 =?utf-8?B?cGxBQ0ZrNXBJaDBEQWgvOTNiMFpkMTEvM1FtRmgvTFc1V1RUaGVia1dsbUNw?=
 =?utf-8?B?bktwODNmSHlqa1ovamJCWFNxUU5DaVBUYktRMkM0a3pzRHVTMWtMUDdQZDVa?=
 =?utf-8?B?TGN3RjYyL0RsckFYT2k0Q014bzd1MCs4L1AwbjI5WVlUNXZjQmp5NDV0TlM1?=
 =?utf-8?B?RXZHNkNLVGhnenVRZzQ0MVZMYUdodWNrR3Q5OEN0Mm5WcXc1N0twU3l6Qk5z?=
 =?utf-8?B?L1pGTFQ1UHJEYnRjdkpUdDZtaFBDUEsySkhFZThDSm1uSU82dElSV2ZRaXBN?=
 =?utf-8?B?aUowalVmcE1uTVZ5MVdWM3hZM05HMkk4c1ZGZDdDV1lKR3ZVS0xOQ2NxTXdr?=
 =?utf-8?B?QS9XVGp3S1RHbVltbkVjNjgwbUNNU2hlVzBlaFFySFZEVldDTFlYNUM0S2Vm?=
 =?utf-8?B?RjArcklQbUg4K1oxYWlzRzl2Ly9NOTFCQjZSU09aNFMvdWIwLzA4ZGlIcWxp?=
 =?utf-8?B?MUlTTGo1eGdUNnNTbWplRVRBRGJyYUZBU3ZTaWZNSlBwU2V2MlE2c1FMbmdl?=
 =?utf-8?B?ZkNXN2FERTlRUXp0eFBuZUNHMHdNQUVBMm4rZGVRaUhiaGVaZXJ5OGE1bUpw?=
 =?utf-8?B?UFQ0RDNzVXIyK1VnT2JvWjB6c1lWK1JpNnJsdHZSU1U0QmFPQk0wZEtIK2Rw?=
 =?utf-8?B?emQzeHU5Z2J0SHRQZXo4cXR4aGdxaXRTbmdyQ3RuNFdRL1JBL3UybCtHWTBq?=
 =?utf-8?B?YkpDN0t2R01zd1RUdnJlb1ZaQ0FsRm95SEpHKzBSd3MzZm52Tlg4VGVGd0M2?=
 =?utf-8?B?b0ptSzZzay8wbFFtK3ppSkJ0TXhhR1MrcnJLTkd6M3lVM3RPWHQ2aWRPMHBm?=
 =?utf-8?B?VWlIbkFwSUxmbnBBaW8yT0M5UzF5aCtzcC81eEwyaFRuU08vYW55UlNWQXJl?=
 =?utf-8?B?Qm5ralNDMXlWdnhpdWRGSzc0WVBmQ1BOQlhqU3VuS3BFQ3hTN2RhVGRFZ0Fz?=
 =?utf-8?B?K242MEV5c2hCNzZKY1R1cm4vZW9ncXhKZElCREhadFNsc0JIeTlVVldVbjU1?=
 =?utf-8?B?M2VJQUNaaGkwR0FhWGcrRVJwSjZKSFdiZVlTQUVWUUd4R01hcEkxcFJzWTI2?=
 =?utf-8?Q?eEdhF4iOZ8xMog/WkW4fyPBY+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 528bc71a-03ed-47eb-1ad7-08ddf090e4d2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 17:38:46.3513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKXNL4FO0JyqaZKsxck3d6SDxblnGzrpUKNO6iYjdrL6EPqPE5HBlBUPuW91O/Zw0GPIkE0tnJNC6Z/kS9YRoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7947



On 9/10/2025 10:24, Yazen Ghannam wrote:
> On Tue, Sep 09, 2025 at 06:53:14PM +0000, Avadhut Naik wrote:
>> The legacy sysfs EDAC interface has been made obsolete more than a decade
>> ago through the introduction of a new per-DIMM interface.
>>
>> The legacy interface however, hasn't been removed till date.
>>
>> Begin deprecating it so that it can eventually be removed two releases
>> later.
>>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> ---
>> Changes in v3:
>> Patch introduced.
>> ---
>>  drivers/edac/Kconfig         |  2 +-
>>  drivers/edac/edac_mc_sysfs.c | 14 ++++++++++++++
>>  2 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
>> index b824472208c4..19470f4efee7 100644
>> --- a/drivers/edac/Kconfig
>> +++ b/drivers/edac/Kconfig
>> @@ -25,7 +25,7 @@ if EDAC
>>  
>>  config EDAC_LEGACY_SYSFS
>>  	bool "EDAC legacy sysfs"
>> -	default y
>> +	default n
>>  	help
>>  	  Enable the compatibility sysfs nodes.
>>  	  Use 'Y' if your edac utilities aren't ported to work with the newer
>> diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
>> index 8689631f1905..3840eef942f8 100644
>> --- a/drivers/edac/edac_mc_sysfs.c
>> +++ b/drivers/edac/edac_mc_sysfs.c
>> @@ -144,6 +144,8 @@ struct dev_ch_attribute {
>>  static ssize_t csrow_ue_count_show(struct device *dev,
>>  				   struct device_attribute *mattr, char *data)
>>  {
>> +	pr_warn_once("Depcreated interface! Will be removed within two future releases. Please switch to using the new interface!\n");
>> +
>>  	struct csrow_info *csrow = to_csrow(dev);
>>  
>>  	return sysfs_emit(data, "%u\n", csrow->ue_count);
>> @@ -152,6 +154,8 @@ static ssize_t csrow_ue_count_show(struct device *dev,
>>  static ssize_t csrow_ce_count_show(struct device *dev,
>>  				   struct device_attribute *mattr, char *data)
>>  {
>> +	pr_warn_once("Depcreated interface! Will be removed within two future releases. Please switch to using the new interface!\n");
>> +
>>  	struct csrow_info *csrow = to_csrow(dev);
>>  
>>  	return sysfs_emit(data, "%u\n", csrow->ce_count);
>> @@ -160,6 +164,8 @@ static ssize_t csrow_ce_count_show(struct device *dev,
>>  static ssize_t csrow_size_show(struct device *dev,
>>  			       struct device_attribute *mattr, char *data)
>>  {
>> +	pr_warn_once("Depcreated interface! Will be removed within two future releases. Please switch to using the new interface!\n");
>> +
>>  	struct csrow_info *csrow = to_csrow(dev);
>>  	int i;
>>  	u32 nr_pages = 0;
>> @@ -172,6 +178,8 @@ static ssize_t csrow_size_show(struct device *dev,
>>  static ssize_t csrow_mem_type_show(struct device *dev,
>>  				   struct device_attribute *mattr, char *data)
>>  {
>> +	pr_warn_once("Depcreated interface! Will be removed within two future releases. Please switch to using the new interface!\n");
>> +
>>  	struct csrow_info *csrow = to_csrow(dev);
>>  
>>  	return sysfs_emit(data, "%s\n", edac_mem_types[csrow->channels[0]->dimm->mtype]);
>> @@ -180,6 +188,8 @@ static ssize_t csrow_mem_type_show(struct device *dev,
>>  static ssize_t csrow_dev_type_show(struct device *dev,
>>  				   struct device_attribute *mattr, char *data)
>>  {
>> +	pr_warn_once("Depcreated interface! Will be removed within two future releases. Please switch to using the new interface!\n");
>> +
>>  	struct csrow_info *csrow = to_csrow(dev);
>>  
>>  	return sysfs_emit(data, "%s\n", dev_types[csrow->channels[0]->dimm->dtype]);
>> @@ -189,6 +199,8 @@ static ssize_t csrow_edac_mode_show(struct device *dev,
>>  				    struct device_attribute *mattr,
>>  				    char *data)
>>  {
>> +	pr_warn_once("Depcreated interface! Will be removed within two future releases. Please switch to using the new interface!\n");
>> +
>>  	struct csrow_info *csrow = to_csrow(dev);
>>  
>>  	return sysfs_emit(data, "%s\n", edac_caps[csrow->channels[0]->dimm->edac_mode]);
>> @@ -199,6 +211,7 @@ static ssize_t channel_dimm_label_show(struct device *dev,
>>  				       struct device_attribute *mattr,
>>  				       char *data)
>>  {
>> +	pr_warn_once("Depcreated interface! Will be removed within two future releases. Please switch to using the new interface!\n");
>>  	struct csrow_info *csrow = to_csrow(dev);
>>  	unsigned int chan = to_channel(mattr);
>>  	struct rank_info *rank = csrow->channels[chan];
>> @@ -238,6 +251,7 @@ static ssize_t channel_dimm_label_store(struct device *dev,
>>  static ssize_t channel_ce_count_show(struct device *dev,
>>  				     struct device_attribute *mattr, char *data)
>>  {
>> +	pr_warn_once("Depcreated interface! Will be removed within two future releases. Please switch to using the new interface!\n");
>>  	struct csrow_info *csrow = to_csrow(dev);
>>  	unsigned int chan = to_channel(mattr);
>>  	struct rank_info *rank = csrow->channels[chan];
>> -- 
> 
> Depcreated -> Deprecated
> 
Will change.

> And maybe the warning can go in an short inline function? Sorry, I
> forgot if this came up already.
> 
> Also, "two future releases" is vague. And it may be confusing if this is
> backported.
>
> Does anyone have a better suggestion, or is this good as-is?
>

How about explicitly stating a release?
6.20, for example.
 
> Thanks,
> Yazen

-- 
Thanks,
Avadhut Naik


