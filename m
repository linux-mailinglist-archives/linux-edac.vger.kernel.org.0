Return-Path: <linux-edac+bounces-1192-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E808FD2F0
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 18:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C411F21B48
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 16:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFEB61FD6;
	Wed,  5 Jun 2024 16:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hQi+bN+Z"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D1E282F4;
	Wed,  5 Jun 2024 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717605042; cv=fail; b=b/W5EEO8Ly06RJM+ROoMgQOoWEZsd0B7s9yrKdKyjP1qPPj0VsrQpjsrh+jzEsqbuqOQ2un0FZWN/8ky6333C3g/nNBwJEO46ZlG95CAHD+RICfx8YB9H5QO+H/8HuSF9CqDgIyCLPno+TW4MwBkceZ5RyYKlnmOJuVcNL3/rYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717605042; c=relaxed/simple;
	bh=c2CPG0P1FPloZp2BmLN3sKNRXvTdHPfsz20YBSrO628=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZQZUCEPzKZolB/y/zroy12A9OcNYgTDowcoZQ1pNxmzjI0f53g4FOM0GrihIVcqxDHtAIiLKqatFnwOMB5FRkVScTbAAKuYisunes6iQrNOBbhbxQ3vV1EafNaYT6TPIysshdkcRvYjUqVJM+U+SJrv7yTrjRhJ8S38HssyU4+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hQi+bN+Z; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9yH2WNnI6M7Jr6N+nhTYvQZxx+hgkuAeE4Mft8LT+821Jqob6P/CzEVpIN6UIOxgc4FxIZKlsJpb0UFDtPu8+wiKZGn4pZeXJezRmLvjRr41ZuZPV3NxQkv59qMSC5PE44ARvH3f6UcWptUiOzjEJWRdKHUQA3EXYTsdCKY/ElO4gFXzn2yzltYtp3NI46nGJL4QmUbT06w/27WfRlFvCCA0oFcRzJSIFGTlnmM+T/ALPgAmtU8iIQcdfd6gcdBs5nurVCkdm4rexdptLosWCXKLuCOaB8tTDP9nU3YLFNRJm5qGaHhib0VSYw2ODBk87GVMhwo7QjK6RypEwoeIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLHBj4PY4zsDNreL4WFhIHQs3tRh8MEulA3Cd9wESU0=;
 b=PpXoUEgpPZorLxXn//iEgW2MhehBpk4YR0hmVxwKZGETdb7eAhVGZYA1XEOqXZRpSnoslj7WhMPKIF0HZLFjUuvUZSzmSFqfUxklVyqW6+r5XVpE08jNrSX+mAGVudFq4I1M3e+7abwmbU1vwwatfgnrGMQqEiQKpcD3Qg7xafHMNgfBwKtgSRdY1zjsKeGk8gBSHiHKghjLO+sWY5lqH+LqBfi9pA4rrgMhM/gJqF6u0JjEaLvuVjaX0g2PNwJbN50Y3Xckac+iy25wEVmEl5pUzqSObred5lRZR2YlX0xE328C4HjVjYdfIWy5vkILaViuXxI8TaFl3TO7cUQOZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLHBj4PY4zsDNreL4WFhIHQs3tRh8MEulA3Cd9wESU0=;
 b=hQi+bN+ZF7gmSr2VofVvlrxYUH1nW/YXjics2AbXwZR9Pz+7VmOUan6H4WPMpoX3hpA6fIO/CLoPBYFrLzaBVn5yTTNs9pzz6Gic7aikyB9Q/csVAkGFUx6eIv1fNGy3CipChf4fvAtCzTlab188TsQLI3Dwh13Uw9KwXK6HlZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CH3PR12MB9217.namprd12.prod.outlook.com (2603:10b6:610:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 16:30:38 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 16:30:38 +0000
Message-ID: <e17b38fe-97cb-4559-be97-36af0ab14789@amd.com>
Date: Wed, 5 Jun 2024 12:30:35 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, Guenter Roeck <linux@roeck-us.net>,
 x86@kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 3/8] hwmon: (k10temp) Check return value of
 amd_smn_read()
To: Borislav Petkov <bp@alien8.de>
References: <20240523-fix-smn-bad-read-v3-0-aa44c622de39@amd.com>
 <20240523-fix-smn-bad-read-v3-3-aa44c622de39@amd.com>
 <20240605122012.GXZmBX_KFQArXB9Lar@fat_crate.local>
 <7a7c2f41-1608-4348-9183-d99aaa51398e@amd.com>
 <20240605161236.GIZmCOdP-CRPJ8-3sY@fat_crate.local>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240605161236.GIZmCOdP-CRPJ8-3sY@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:408:e2::34) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CH3PR12MB9217:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f5afb1-8fd5-4079-6a1a-08dc857cd537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dm5JcEhDdTFOT3g2Qng5NTRlaVJ3RnE3cjJVWU1GUUdxZ0xzR28zM1BSdjJ6?=
 =?utf-8?B?RDVPNDNrRFZ1M0NWdjNyaTJzUXl0TitDWWd6T1NOMmZoYSs4MXY1eFpsdk9h?=
 =?utf-8?B?UzVMZ0tNenRwenhlZ3hjcXV2SC9BUHpYQUtxSUFYWG1manJkUG4yY1FTZWdW?=
 =?utf-8?B?ekhLeGNKL21wbkdXRzlnWWx5cmRGd1cxM1ErVzZkVGxVM1VBZVN5K2RnTUVD?=
 =?utf-8?B?QUJKVURzbU54eThuU2dpMkp5MmcrWVJUenprR2Nob3R5elhDeUc3d3B3QWIw?=
 =?utf-8?B?MkFtSFVTclBsbFN1L1RpRnZ2clV5OEo3bUVEUGQzTTgyNW0wWW5SWmwvYzBG?=
 =?utf-8?B?NWJKdzZhYUJrVmJtTU92WjhFWm9pck8rR0hwUWhheUtTeDNYV0srU3JEOUxz?=
 =?utf-8?B?d09kbTFBdlNSU3RaUUt3VW1hQ1RGa3lkZzFZNFJmemdGSHVja2VlNkx3QTY4?=
 =?utf-8?B?dWc4U1E4S2F2cDU3L1hNd2Z0bElGZDJLdEQ3ZDlkQ0x6N2o2V21CRWdWQzVr?=
 =?utf-8?B?MUFENXlqYWxTQ1RwMWMycmdhVzg5a2RiYWdVd0JmcXpqWlRjdUlVUUxCaVpK?=
 =?utf-8?B?M0svczl0ZUdyS0NzQmtFaGJFQVJtTkZNLyt6ZkNKMjFHN2JhVzBTU0hDbEty?=
 =?utf-8?B?MEx0Q3RYVlJOOW5wdGYxbzlsUjlaeHFESUNqVFFkUU9SR0xkNEcyY2hBa1Zm?=
 =?utf-8?B?encxK2lMMnNVcFlYZi8xdjR5cFlsaFlVL2w3cU1jN2RsS3NoNVduREdFeW1v?=
 =?utf-8?B?ZitBaDNUWEtud1kzYkFnQVRPWjRKMUk3SXh4WFVUUUVEa0k0SHlTd3k3ODN3?=
 =?utf-8?B?RnVyb0JGeXl3Z2JNeTg0THo4ZGxSYlVLcFUzNmdteWg3ZEdzb0t3NkY5S3ZW?=
 =?utf-8?B?c3h2emE3TGhSWTR2K2ErZS8rM0JKV3dWVllJcjZQam9VSXhTb2tXZXpDMmtC?=
 =?utf-8?B?THpQd0tYbWdUcnc5bk5kcm1wbDRyOGVRNWd2ME1TRWQ0M1RBcGp4cy9MYnNI?=
 =?utf-8?B?emRiVjYrcGZSNDZFVEFLN0hvbllRNVZRbEN5VzdBZjJqOWt3RWZlb0ZReXgr?=
 =?utf-8?B?SEhwclMrMEFWOWlOWk9sQWdBalJSM2xsSTEweXB4ckRUZFdMWHkvVFBIbTBJ?=
 =?utf-8?B?WE5WWVg2TXl2bmFNUmVFWUlHMFJHd1I0WVovV3JTc0g3K2VINVQ0VEExUDdp?=
 =?utf-8?B?N0RnUkExUjdxWXIzYXNOSnk0dmJtREs3VkZnWkxGellLQmt3TzlUNEhMOUpI?=
 =?utf-8?B?VEdkV2hRdFRtYTNOcXQzcEo1L1phdWxvLy94N1kzNWNtMWptcUNyNFhyRXhE?=
 =?utf-8?B?K2o3NmYrdmhRdFEzZWMyYmtHUDZ5dlIyS1RONkhXRDAzaXVJdUk5RjZxakw4?=
 =?utf-8?B?QnJGUHR6aE5RVzZ1eEtxbjFkeHppeUlzN2VTN3RYTFZrbjRTT25uMVdmbFpE?=
 =?utf-8?B?VkJjck9SMWVMbm5ldUwxbXFBOHJuT0Y5ZU02ZEJRdzdaQWo4WjVPelpSekdT?=
 =?utf-8?B?YzNGaitnamJDQ0lCVGhhOGgwRUtTbGpTS0tZWjZrRUVwalEzMk1sTVl3RzlR?=
 =?utf-8?B?cEZGUEMvcU5GVEtQR1JFUjBRc3hSaHNmck1qYTZXYkF1Nlc1TTYwOTAzYkVY?=
 =?utf-8?B?TU94aVQwQzZ1dHRjT0VMZktOYy9pQWxnNVFxKy9LY3REMVcwMkZyWUQ5a0Zy?=
 =?utf-8?B?T2FRZDJCY2UxaW9uUWJwUkZ6YXMyYkJzVW5RNHVFVzVyaWFHZkQ1K3VpSlo1?=
 =?utf-8?Q?UrrLZteJBORt7pLfn4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzBOMWlCWmJuN2t6K0NiYnFYRXJUa0RJNzFyell3a0pWODhSNWdjY1FPK2hE?=
 =?utf-8?B?U3JUNGt4MmFhd3RnYzAzQmtoQ245b3VTQTRTT1ZiZU02UnZrSXUzQkFxamlu?=
 =?utf-8?B?T1VDUmVJUGowY3RkVTc2YndoWFRpZXNUME1ZYW4vTGd4S3BEMWpXUVZGb0p6?=
 =?utf-8?B?NWJGVjlaZERuNllOeDdwZWdxVGtmd1dQejl6SGFLZ1NyeFhmTXRyWFBUTmxt?=
 =?utf-8?B?V3p4SkZNbURDVmlWTVUzWUdocmZDTFpid0ZNNXIyKzNEVzhxWGRkK3JBME84?=
 =?utf-8?B?WEVmWkM4Y0p5Zk1Na3BkU0pvSE1ZSTdEM1hBancyRWQvbUVoVW5yR05kRWgv?=
 =?utf-8?B?UkpxcmMrall4bEl4ZlF6MEo0YlE3L3Y3elhSdk1lMWRZZEl4c05Cdm1OaS9o?=
 =?utf-8?B?cUdYbWFLc1NwZk5HQVhxS2ZkQ29nZTNkTFM4Zi9lV1RhYlZCeWtYVlJZR0ly?=
 =?utf-8?B?UDVNY3RLTzJXUG1MTFVyRmgwZi95MkZWaFdmSzNUR21sUjhiQURXTkI3Rysz?=
 =?utf-8?B?bW0zUDlsS2xxK3FYT2FNQTVxbTNUV09xazg5UzJKV1NCSExHKzlnM3o4STNG?=
 =?utf-8?B?VHVWdmczTWlicTM2eUdBc09EaFRmMk02UHYzdDRWMDJ1bW9ydkk3bjRZTG9H?=
 =?utf-8?B?RVJNMUpBaHZBMXVHb3VFWDhZMVFVRm5aU052R0RqK1pMSDd6VVpXUWlldENt?=
 =?utf-8?B?NnhheXliSHRWUFlOMi9YTGYweUVkTm83T3BIK2dqbjVpaFNqRktSclFiTWd5?=
 =?utf-8?B?NkZaNTlvMUh2SGNkS3ZIV1V5c1h4QmhIQWcrUHVYNGgwaWVJVVNJS1NYLzhJ?=
 =?utf-8?B?b0xKWjFHYmszZUN6S0VyVUVrdDBPazBkcnlNZXlNMkovQkIyUGZnd2Q1SHZO?=
 =?utf-8?B?aUFKZjk3SjBJVnA1YjJwZ0RWNGpKTHJjbE5XTVJRQ2w2UWRVSUZ1OFNOOG5n?=
 =?utf-8?B?Q3Z6U3hLL3Z1ZlpsTVIzNk9YQnFFM0o2UXJ3RE82ZFZrY1BzNS9yUDVlYzV5?=
 =?utf-8?B?ZVVFWWpuK2R4dmxiMSt0WUt4ZmN2cnA0QktLMWpIbmRPVGVIUkJ1UzVpcHVM?=
 =?utf-8?B?UFVqcHV6V0hOa1F0UWp2M2pRdElwU010M01UdW5SODh3MXdZN2dpdjVGU2tM?=
 =?utf-8?B?Zno4R2MwYXJzVGNRL2Ywb1BNcFhmVkY4V1VuWnBXV3pSY0VNTkprejhuOFVn?=
 =?utf-8?B?bzFhcUJUd0FYRHhpdzZaeThqWm9PZzgrMDM4QmdSZVpGZ2lBS3gyOTZsZEtm?=
 =?utf-8?B?R1dnZzcxbnR2OGV4bk9hQndheTR5MVVZR0h3cE9wdCt5TXVtUWQrZkgyVEJL?=
 =?utf-8?B?NlhtQ1JVT0c5MWlNNXVoaEc1Q0Fid2ZaV1kvZUMvSUwyK3pnNURrRXFPTitF?=
 =?utf-8?B?VHU3dmVrQjBCbDVVUWhlK213dHl5MCthL3luYjFjTnJwNzl6cGQwYlozaEFW?=
 =?utf-8?B?em5UQ1J0QUs0VVdEMFNWTEphektoRGZyR3NoRnc3NnE3MWZtZGdrdU1IMlYx?=
 =?utf-8?B?M1MrOEFwQU5iMlM1cHlUcTVlL0Rham9yam5sa2V2ZkRWZ3p6YlBwZFZ3YUVx?=
 =?utf-8?B?RXQzZG1GVHhZa1QvK0FGblgzMWVSbFFzaXpHb3VXbXdWT21FTlJUYW1ZN0g2?=
 =?utf-8?B?cE1zUUxjZXFFOWVCK0RJU00wSXZrd3VlVFFPMytCTXNTQ0oyNXpUSGVzVUJm?=
 =?utf-8?B?L2p2RnpVbk53UUlWbVRvS2tFZEVTZ3JrbXc0bVJzeUJLR2JMdDhYNlBRdUhw?=
 =?utf-8?B?NHI0dnpPVWxNaEZqSFprY2F0VllXRVltUStGNVZEazRBNUtGbEFRZEd1Yi9t?=
 =?utf-8?B?ZjR4Yno4SGM5VDA0QXM3Tm1jemFOQWpKV2JlUWQ1dEljQ3oyWXJBWEpHVHIz?=
 =?utf-8?B?RGNWVktvTm8wYTVydklraG9VTjlGRGZ1Q3llOFBOeldQVmI4OTBKdGliY3lk?=
 =?utf-8?B?WFhCRTEvOUZyWEpQQVZVRWZSbm1yRlJzTVBVbUJKQVFyS3l0VHpvWXptNFVp?=
 =?utf-8?B?NkJOQjFMTXBrTDFrT3A3c2xkck00V25Gb0VDQi9KOFBUT0JWQ3N0T0lEcTRX?=
 =?utf-8?B?ZUMyalFIZHUvRVpSRmNSa1NNanh3b0FtR1RjdWM2WlllU2FHc3Z0dHJoWDRH?=
 =?utf-8?Q?J3zN+TzySkeZJoxxIF4IV16+c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f5afb1-8fd5-4079-6a1a-08dc857cd537
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 16:30:38.0466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMapannxfnDuxd2HonLc5rQy7dDstuGUlQGbgHDlMe0ciADvLiWHxuTrdgWQPkS5auRZF6cjjqjOnnh6KiibBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9217

On 6/5/24 12:12 PM, Borislav Petkov wrote:
> On Wed, Jun 05, 2024 at 09:41:51AM -0400, Yazen Ghannam wrote:
>> I agree that patches 1-3 are not stable-worthy on their own. But I think
>> patch 4 is, and it requires 1-3 to avoid build errors.
> 
> Which of the rules in the first section of
> Documentation/process/stable-kernel-rules.rst apply for patch 4?
> 
> Because I don't see it.
>

"It fixes a problem like ... a hardware quirk ..."

This is described in patch 4:
---
Most systems will return 0 for SMN addresses that are not accessible.
This is in line with AMD convention that unavailable registers are
Read-as-Zero/Writes-Ignored.

However, some systems will return a "PCI Error Response" instead. This
value, along with an error code of 0 from the PCI config access, will
confuse callers of the amd_smn_read() function.
---

But I think it's fine to drop the stable tag after reading through the
rules again. I'll do option 2 or 3 if there's interest for specific
branches. And the cherry-pick thing should be easy to do if all the
prerequisites are already upstream.

Thanks,
Yazen

