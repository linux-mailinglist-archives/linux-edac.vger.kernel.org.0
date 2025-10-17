Return-Path: <linux-edac+bounces-5122-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A205FBEAE91
	for <lists+linux-edac@lfdr.de>; Fri, 17 Oct 2025 18:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 000325C0AFD
	for <lists+linux-edac@lfdr.de>; Fri, 17 Oct 2025 16:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0742E2D9ED9;
	Fri, 17 Oct 2025 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nzG1TqIM"
X-Original-To: linux-edac@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013030.outbound.protection.outlook.com [40.93.196.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA82C11C5;
	Fri, 17 Oct 2025 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719471; cv=fail; b=jx/9nhubZ/gF7TX4oW/uM2db2A8+t9696CmVon5804LR4joRy0c803oi4MWLOrPOALCUF/uc3wFNsgJ4x/53ojjRA3YpwT5Gi6nV2PbnRBcYwsV9RjtmknvCaeogaAck7mjxF/s+WlQJUmSKNJJoropI03183+39a0W2zCDSWmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719471; c=relaxed/simple;
	bh=y55F+StwUuURM8tJ9Adq++N44oP6oTqPu7zCFjFBn9k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H0iOjZlDcUQs3WnjSV66Xy2nYX+GI+fR6grnEuHXPAa0wZkCz3ygDTGfSnveUKhHWSi2xZ0Ly5BMDXlfT+CPeikIkO5wo+N1Z2U74I1Mwe/wbCV2Oldod0YLcxGmypsvFMIncw1voWlbLbM5YKlvVANG45YHGcw64vxdJtPAPdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nzG1TqIM; arc=fail smtp.client-ip=40.93.196.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hd9yWtcn9S9GPZ5LQdgt4spSEiNvZwY4Hv9FVPMGipVKP34NqrdhFIVTWPtg92ccPFwr0uGyx5SfhHla/yMPWH4SbzjtQGlBbYuryoxRUBwU7n21F/sgiC3GQu4Pt6qEMVyJGszaGR4ryiG1Zi07NtaVKvw+OUx7qSpLlZb4ZOCfdjnXBjhYIKTJR4ByEe0Ofi+tc4X5obUkNPe3Ns4LhhCT/3F+v7zt+TyCauxR6I078s9idXV+VBTP4KzbX50bDXEtMolAYIirTOEkI75pGnBHuprRfC67f96EQMxoOuX2qNgK72AbtzaVoVUfv3IQr5KHe8fy9/ScGQmEZy1r6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaZb75Vby/Gws9g5dzC7gZhIUK92MTznjTIrSztnnp4=;
 b=KSwCyiemc1732w0L4aStC04XMH23i9Jh5mjc5SD4r+8hbY7lnED10/+iSGcqtlYImgiyKCHS+j/AqGPcv6qEVHuth6rOcwqpwlThYHXOcyCV6ZmLYzz+W7K7A3c6vCRPuxA+feWKsWd42lJk+3sIl0Xe++Xj7zXObrwBUoxzp4csDkFqGFZKIuhJa3vRSqvFaCmHujSTC0u7LUHxUzqHzzuiprE28gi/XimXCiZmHM3RDV++m1M0PYj/asfIIfGoDFKTRTVGTKORcpJTYqs+49XENu1oFJdqjo/BjpIcnu6K09+7Fnrfm9vuCjD6IrJ7XmJH0gjvDDTUpgBPfczfuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaZb75Vby/Gws9g5dzC7gZhIUK92MTznjTIrSztnnp4=;
 b=nzG1TqIMu3xXwiW/Qvjz1c5ApkwtRQDMEYDBWbt+Nz1K4DIxdhEifvURjBqBEPmJfIWfT3xRT8VJZJR601iI/5K8c+GGyNrK6ClTtPZLSFHCUOim5MqVc9Aqh96b89wss59OwGGD8ODoXOHRHgltKCZuKbK6+n//zo3l8dOpsFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by PH7PR12MB6763.namprd12.prod.outlook.com (2603:10b6:510:1ad::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 16:44:26 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%7]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 16:44:26 +0000
Message-ID: <020798df-1abf-4097-a8b7-ecf13b7eec9a@amd.com>
Date: Fri, 17 Oct 2025 11:44:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/mce: Add support for PHYSADDRV and
 PHYSADDRVALIDSUPPORTED bits
To: Yazen Ghannam <yazen.ghannam@amd.com>, bp@alien8.de
Cc: x86@kernel.org, linux-edac@vger.kernel.org, tony.luck@intel.com,
 linux-kernel@vger.kernel.org, Avadhut Naik <avadhut.naik@amd.com>
References: <20251015172452.3649720-1-avadhut.naik@amd.com>
 <20251017143139.GA1131586@yaz-khff2.amd.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20251017143139.GA1131586@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0150.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::20) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|PH7PR12MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: cabe13f9-e41f-4441-eba1-08de0d9c6ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1JXclM5U2NKeHZjRUJXWUpFaWtLcXFXWGpkT1hNZVUxMHBPakptTll4ZjNC?=
 =?utf-8?B?VmNSSk1rTndaVk45dkJzV0FmZm1QaTBVNVhEYzlGWnhaY3M4eCtGTktWTlVH?=
 =?utf-8?B?M0J1Y1dZZEdhSGVOUzB3S25JSXFFVTJwVWJoL3NTVmFoWUhDOE40SlRoQnlE?=
 =?utf-8?B?T3F3ZjlFMktrejcyNER5a3RLTUhvSE4wcEdxSzJod05QWkFZdEJPbENBa1BQ?=
 =?utf-8?B?d1pwemdnbjc2U2ozVUxMdnFMSGZJMnVmM1d0cG1kYnhydjN6d2x0WUpkTzhP?=
 =?utf-8?B?NjgyN3RZVGdqb0xLVWpDRnpkRG9DUHQ4OXNqMzhvbWdZNUU4VjZ1MUY2U0N3?=
 =?utf-8?B?bytJQTVjVFErdTluV3RFYkFKQXZBd3RCQWlJbDhOYUVaWnF0dlBqOFNBRUly?=
 =?utf-8?B?eXJMajlIc3NpK2t1eVZ4bXZSb01reFhVaS9oOEsyTW5INHFDYnJubUc1NGVu?=
 =?utf-8?B?MnNzYng0eUpmQ1pWWjV5c1BIQUVKR0NyeTY1TnBySjJuK1Y4bUliSEhoN2Zw?=
 =?utf-8?B?WkpVa2pNb0tvZ3lHNFdWZkx4UG9QVTVYaStZZi9iajZGSUswZjdodVpmNmd2?=
 =?utf-8?B?TkdXMlp0TDZPTjR3MVNFOUg4Z2U5SS9LUTJJM2hCbWV6QWNQUUg2TG5VOUt6?=
 =?utf-8?B?czZybGFZRTBOdnFCVjVERnIrOFVwS21BWUFzblN5dkJtSmtnbVFwK3NmQkxC?=
 =?utf-8?B?Z2xGT2RIbnVLZmh1ZnNzTkNZL1dOWkgzVWRUdlgyM3c0VUpPd1Y5dlV1SmxN?=
 =?utf-8?B?SjNEMXJKeFVtZkMrc2xRTkZFRTRsZTF4elc2YXdiZHNveWtXbnd4QWphN0NM?=
 =?utf-8?B?SFd4eFFsZzJNVlVSTk4xZUoxZTJ2MURGM0t5bnQrdW9ubmR4NXpUb0JJK2xE?=
 =?utf-8?B?eTFQUjU3VXBtQitOWVpURWhUNHdSWkRreGczaDVGSjVnc09rOTdoQnJqRFNZ?=
 =?utf-8?B?aVo0RkZlUlh2cVlnaWFJUXh2ZjhubWh6S29Kd3c4SkZzaE5QNThCNVRHYWl0?=
 =?utf-8?B?ZVdDdXFqYjBYd3ZqSDhuejEzZk42eGU3YWlnZHVraTZoRVllNnlTeEZDUTBX?=
 =?utf-8?B?TEI1WTFKK3d0MmdDM2JKSi9rdTlHS2l0cWQ1L05QQzdQMGxtWlV1K0FGM0Yz?=
 =?utf-8?B?bitXNXBmenRERG1rVEdkSm5QRDd3NkNacXJTcGdlK0NIVUdGT2hSNG5xd0du?=
 =?utf-8?B?eW81RFVCdVF2VWNoTE02ZlNaOWdCMzBkVE1SNitjd3Bsd0dlNEFDODJIaTBZ?=
 =?utf-8?B?ak1uMVFOUW1id2ZKS2ZEcGRDTGNiS0JWT2VSdElXaGxRbTdBWWsrRGcrSDVy?=
 =?utf-8?B?ZUVMUlM0UzZPbUJPOTFMdzQydFZ5QzVsRnFSQmhoSnh1T3VxTXJoR1BicjVS?=
 =?utf-8?B?Y3MzYzZQS3Rka2ZjU1RTTGVsdEFVVEZZTVZjS2RwTEJZMzhPRmVzYWRicjVT?=
 =?utf-8?B?dHJ2bGtqL1B2RXJCcS92dlA4R1VMYm9KMkFLdTRWSVZNMDV1S2NjK25SaVNP?=
 =?utf-8?B?QVZ2d1o4TnRHVi9KazVyUkNySi8yalFKclBIaC9JRkIzSmFkMVNqVjV6OStI?=
 =?utf-8?B?WmRScnAzTXNkV3FYMUx2cG1IYUpwTWdyRTd3cFVmVnBCM3FoQWlXK2d3MS80?=
 =?utf-8?B?aURiUGdEU3FZWWpFdHFhMjBvUVZkeG1YdGExOVdRblpmUFhqN2hSNXhEeDNt?=
 =?utf-8?B?bUp4REYyNXIvNE1LNnRtY2E2UG4wM3FIZlAwSVlNM0Z5T21qVTBRcHUyUkJC?=
 =?utf-8?B?NlRwQ2FQdGtzbFVkRkQ3YWpaeHpLRDh5MzFKM1VzOGZQVUJReUtsSzc3SmJY?=
 =?utf-8?B?ZkRBVzZWS3FKdFpzMnVsdjRkcE1sUzdzK3Fmbm9MeEZoUS9zZ3lNOXFGeDdK?=
 =?utf-8?B?b3R3MU9wMU9XNTNEdXV5V0ZhVkFvQ1FwU3BxVGVZNmZFckIvV0ZBM2pWNVU4?=
 =?utf-8?Q?WefteHnlIJDNvlwMa9EEC+7HSAIzD52w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1N0Zk9yUnpMV1dFVmhVRTdaMUdGUk1NUHhDSGEvRTVFYzVOdDRmSWdzaVZT?=
 =?utf-8?B?U20xbWQ2MXd5K045QUc0OG9mMmpGRlZtRVY2MWFXVTdpRk1POW9BcXRoaDA2?=
 =?utf-8?B?d1lZa0RaRkpQcHhGWUF5Y3pBcXdlMmNWU2RJeHVqYU56L2tRc2k3ck9FN3cr?=
 =?utf-8?B?eXBVTGo5a2FiSTkwMmZuNVU2QllIS1oyejNpRlIxZ3MxQm0xWjJTaUtWclBq?=
 =?utf-8?B?aEJuUVliYVFOK2lqREZ1V2pMZmQ1QVhUdUg5REMyVzBmelVqWHBFQWdMODhi?=
 =?utf-8?B?bHRaaVBOTURHTms5NjJEbU03VkJ2R0ttSExTVmY2TkphQS90MitMMkhaWmN0?=
 =?utf-8?B?V0ZaRVlKMWxtSGJIcStzV2gxb2dVL2pON0dCRFlFREcxKzhoRWRTZUpnc0Vq?=
 =?utf-8?B?a3FqRGpnaDhyRU4wakVIbjltZUwrbEFLdUlzL0E5RnVjaXRsRUM2a05ZKzc2?=
 =?utf-8?B?ZEo3cTlpZ1FDSlNnZkNRQ21Gc3hzaDNQM1dnUHR0T3I3SHo1M1p0aDUyUjRZ?=
 =?utf-8?B?bFV6cUh2c0pXN1IyaStPLzdRSHpITGwreVJFQ1BMSmtKSDIxYmRTczM0ejBS?=
 =?utf-8?B?OTRQMWljU1JBbzZxSW4zSEJBY254ZFRRQTVRR0k3SktZc2xWMVpGZVltOFVk?=
 =?utf-8?B?bzkxRzg1NmVUL05iSFliOGVDYXNOWWFLV1o5V0ZTK01sT1UvNWZQaEJLMDNv?=
 =?utf-8?B?QW16LzB3b1B6aGJLcjJKSWppNWhCZlFSaTN6ZkJrdjFKakhDV0wyR2lDNDdN?=
 =?utf-8?B?d3RtWUZ4eEJ3emltSXRtNlYwOUJHMWJDR1lzVFlvY2dZY3JSd2Z5QlQwVmN4?=
 =?utf-8?B?L1FwQTRQQlY1L0JTRlRjMHlnbkpiWjFBd1lsVFlabnpaUm52RkNWY0dpWFlz?=
 =?utf-8?B?YkxDWjVWMHlZSTJDTXBpWUxrRFB6anVxb3R3NnJNOVJVNkEzZVZEOHQ4bWIw?=
 =?utf-8?B?TGhDYVlONFJ4WHhjS3F5TmcvWGlZWEkvdGx0dTRsWWx5R1hDTGYyaUxUMzJz?=
 =?utf-8?B?QXdwblNCa2dwN25DMlRpN1dHTnU0cHF1ZEZ0VVlBUVdEUm1ZTmZwVzFZSC9Q?=
 =?utf-8?B?REtUcHhqeHl5aWhOYWZPNzlabGRKNVZYZWk3T3NmQlVkL0p6eE82cnZlSWpz?=
 =?utf-8?B?RUF6aTdhY216bytyYjVQMXUydnFLOFlmVGxHQ0lLWXo4VzBIR2lwdWp6QzI5?=
 =?utf-8?B?UmZxQVBETFBrOU9YYzgyazhQSThZc2ZlZ09mblVBeWx1N3NVS20vU3VMOWtS?=
 =?utf-8?B?dVZKL0lVa0xXY1lReG01ckpPd3N6cXlRY3hjSTI0aHEvajFJM0JtM2dRUDdv?=
 =?utf-8?B?RTV0dytYVTd0dVowcjBRcE5VTVpFbVRHVlViaVFjalBrU3VQQ1kzbjJia1Zv?=
 =?utf-8?B?UDlVeUVxRDZrMEl2RW1vM1F1WTlDeGV4TTYzSmVOdXJHbURya2JlUmhZSnhP?=
 =?utf-8?B?L2JOTStxYXFWTnVwN1pjaWZDTjhJNlcxcGpwK1RkdTVzano3U2tzZ2dQU2t0?=
 =?utf-8?B?RDJnQUpKbndGRFplTW9icURaN2p1VGxXQXJyTGwvRlVkZ0VjcnJ6MzVVODdm?=
 =?utf-8?B?Slp4MDRodnlObEh0Y0hkMW85TnNXNUUzVG4yRFloOEUrZDE3bGtMVWJiUmVH?=
 =?utf-8?B?dnk0QUJ0K082RmJIdmYzK0ZmTU5ibCtUYW1DU3BNc2owYTBIejg3RFBZcW1U?=
 =?utf-8?B?TENRVEFmdGlUTWlWZ1R5K2MrQjFhY1dDL3g2NjRWMEQwNHlyMEdKcXkxUVpN?=
 =?utf-8?B?eDEwMHEvVC85cFc3QlZxZHRKSVpNaTFoNTdLYlk0SDg0RzdXYnkrSHU5TVA3?=
 =?utf-8?B?aUJ3MnJJL1JFVWpBbFI4c3pwanpKaGJLWUZGT0JuZmVkV014QkJReThQeSs2?=
 =?utf-8?B?aUoxZm1DYzRpR2hxRGxNZXY4amhzVXFScm5JRk9hamhpV1Ivc2IvSkNoQnd5?=
 =?utf-8?B?ZTlsZlA3c0NBTkpQc0lFcHZ2U2NGNkwzc1VBVVNFWWFuSDBFNEZqeE81LzNS?=
 =?utf-8?B?L3F6Nk9LUW9sTW1kNnQwR2FLQ0M5cW4yMzI1ZFBwaWFFNUVkSWxBRzhja0Rr?=
 =?utf-8?B?MmdKZXVzMDhua3RyZEVseGwxcEpQZWcyN1BQNE5RVWFuL2tlUkNOU2lvL3F1?=
 =?utf-8?Q?Q+ljNRsyQJzvJoAi3srnne7Vs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cabe13f9-e41f-4441-eba1-08de0d9c6ee7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:44:26.2133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQbCS7jk+kAZZHH6Vamvebn/v5CfgxXH/UmDSnBawq07EuiwZ9HM2sjZwccx6QYNK+Usz+RZuvJIK2K88ULMrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763



On 10/17/2025 09:31, Yazen Ghannam wrote:
> On Wed, Oct 15, 2025 at 05:22:25PM +0000, Avadhut Naik wrote:
>> Starting with Zen6, AMD's Scalable MCA systems will incorporate two new
>> bits in MCA_STATUS and MCA_CONFIG MSRs. These bits will indicate if a
>> valid System Physical Address (SPA) is present in MCA_ADDR.
>>
>> PhysAddrValidSupported bit (MCA_CONFIG[11]) serves as the architectural
>> indicator and states if PhysAddrV bit (MCA_STATUS[54]) is Reserved or
>> if it indicates validity of SPA in MCA_ADDR.
>>
>> PhysAddrV bit (MCA_STATUS[54]) advertises if MCA_ADDR contains valid
>> SPA or if it is implementation specific.
>>
>> Use and prefer MCA_STATUS[PhysAddrV] when checking for a usable address.
>>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> ---
> 
> Minor nit:
> The $SUBJECT could be simpler, like "Use new physical address valid
> bit". And leave the details and proper field names for the commit
> message.
> 
> But in any case, looks good to me.
> 
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
Thanks Yazen!

Hi Boris,

If you don't have any further feedback on this, do you want me to send
another version with the subject changed per Yazen's recommendation?
Or would you take care of it at your end?

> Thanks,
> Yazen

-- 
Thanks,
Avadhut Naik


