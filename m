Return-Path: <linux-edac+bounces-5133-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BDFBF2ED7
	for <lists+linux-edac@lfdr.de>; Mon, 20 Oct 2025 20:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D25D34AB0F
	for <lists+linux-edac@lfdr.de>; Mon, 20 Oct 2025 18:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6BA3176E7;
	Mon, 20 Oct 2025 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wJULCE1H"
X-Original-To: linux-edac@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010070.outbound.protection.outlook.com [40.93.198.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B2227B345;
	Mon, 20 Oct 2025 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760984891; cv=fail; b=itu1LRxEH1IkTrF7n2SCXn4dqtbGADJLZ1gpak1PoPydjs2NvrViYmayw/h2tppyE0j23iQ0RR8X78LZ1GcvMdDVd81+fACDNtPKW/KqS/6HgYaKnh7MnPZWY1QKj7k3KyWnp/74tH+JkJJ+lJpZ0CIFYui4yxx+0GTm7HrW69U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760984891; c=relaxed/simple;
	bh=99DRjhMQ1a2WdikMGKVePRjbEf58NuBPn6H93Amjvks=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S5P6m+G1kFSMlRrq9ZU1eygKYD4tAByChBOR6W2p1kBfDeM/ad5CaBnCpw2mW8c5GoCJIJpNi9dirermQq7eAfcjYyS6FxsqSQyiq324O8hPQh3R6enKlpp371t297bwkvr1P/kmT4dj6hxn/kesONs4XGCbD67fFrkk/+XY0IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wJULCE1H; arc=fail smtp.client-ip=40.93.198.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRcdy6zlCWFx6qtgIUlxYpgPAQLlloDRf3qPxqcPNFzItNcxcvpHUN8sBnWpGFNc623vNf7IKG4X8/0LobOm2rIH1b/Ex/fkSSC+iQfGrSsFEugCa4je1p9zMlwQr7m7JeOoyVoCmorZMKWmFTsR/Q2zcDKYNDro4atv2M0tyHIJy7KCB59BcEGYHcruHPRsFQ/OZvorZHpaNA1GsGox2l3wHJ7D2XTfpzNM1Jhu63YdIm8ogO22v7F9fGAIlh3pqH6j6cOWdPUYfex0ByNbKYnO0yLundVcb+Ws+g/qiN8vY7sjGLtwSem6yuoINtmhLgDQkg87XgtvG5M7QDxsuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6NjF5sWN+n3z6CFgRtKWPG3S4KLe3Kpq0n8AqAP10Y=;
 b=Sdf45lIYcnQqmSoIcO9/sV2Eooyi6Tlm+9/WJ6LOf1/YFO3QO/zSAm2ZeOTvzt7MPoNBtT5JUGXk1pABFpYeVyAeuaRJMseXQIRzDbK3cOk7CCy0fbIWGkjqj4W2KBZF0CNlrPsm/e4tas5dEnP2fNw1jgDB/NdRubpTp1gJlQKhXXYuNL64VzwDwcbyutxBME9606irv4RKmPDfkuA7K5eGjxybwXL35k3wOja/M6QqZAKWgLbhiEcIy9mc5PJJ7Oj0RCnNHAZTuVvD+KlYqoMu/gEJ9bPsI+nKhU7j4rsoYAK664CCfpqj7q5dvHFWwOPq5E3NJu0XV36yoVPxEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6NjF5sWN+n3z6CFgRtKWPG3S4KLe3Kpq0n8AqAP10Y=;
 b=wJULCE1H224TBOFN5dqMsmAA7DlLbG2zToccWvC3lVTfMjIhUyVQHXYxAEFO2f+GrotbPkfTiElDzEOmQAdWGjCnx2jVyEl5m2TAGQXOhjB8MF7pluxBxqNtl6OsVosQQ1QW3Ua1F+s05u1xK8nE9p+uZpeLOeGxaThKrI3lTiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 18:28:08 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%7]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 18:28:07 +0000
Message-ID: <07a6d970-fda7-4f6f-8853-3e08392e63ec@amd.com>
Date: Mon, 20 Oct 2025 13:28:05 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/4] EDAC/amd64: Generate ctl_name string at runtime
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, yazen.ghannam@amd.com,
 linux-kernel@vger.kernel.org, Avadhut Naik <avadhut.naik@amd.com>
References: <20251013173632.1449366-1-avadhut.naik@amd.com>
 <20251013173632.1449366-2-avadhut.naik@amd.com>
 <20251020134756.GIaPY9jAoeEcBp95-k@fat_crate.local>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20251020134756.GIaPY9jAoeEcBp95-k@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0146.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::28) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|MW3PR12MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c31ace-04d5-44c1-5f01-08de10066a54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnJYWDFwSjh6ZkMrU3ZGS1Y5RHhyUnpCRWhYRHMrbHFIcEY2cjR4bTNDQk5l?=
 =?utf-8?B?UkJxb0dmYmhwWm45Z0tmQnVMTDlZWk5ILzZTTHFXRjBwK2NFdWFad3ZWTzA5?=
 =?utf-8?B?eUlUUFZDMGcwdFpQc1F0Skh0SXpXN1hyTEhUaWpMbHFBOFlNQWxFb2x1bXZZ?=
 =?utf-8?B?a3dUVEw0N0FDc1BNTkNxWVlsNEhGaUFONEQ2US9BK0dNQ0szMEZWSDJlWit4?=
 =?utf-8?B?akdOSG9hMjBDdC9vRkQzUUcvRmhUUS95OFNXc2M2KzU5SG55YVN3Q1NmU3gx?=
 =?utf-8?B?dU5Bc0JaL0pyOE5zOUlML2xkc0x5RlJKZE9GMURmMHV4eUlCVGZBWUJpcVRR?=
 =?utf-8?B?QVl4OWh5dTlMTUtzWEdjRzBNYkp5bm1UaGdlZnZuUjhjOWlLdFhsR2VlVkky?=
 =?utf-8?B?QTZrWXZ2UHZBVllkbnNOcTVUVXdyMWRDWkxOUm5KMlRRVVdvWHBtVVV3L3Q1?=
 =?utf-8?B?dWNSWS9HUW9ZdlhRMWs5U1dJdGMwSFF4RXpieW12ZGVIYjdKblM4WUFaUkpG?=
 =?utf-8?B?Z3VvbllrRExFdUdmU2dVN0ZZOWMxSUd5Z0YzSzFodmxkakgrTmZweDNYd1dK?=
 =?utf-8?B?R0RiclFLYzI1K3NMMVdWTUQzbUc4SG1rSEFHdmNlQzliRTVYSDkrbkkxNWYw?=
 =?utf-8?B?N2R3TWxReU95NDByU0hjdENwMzM1aEVuTDBMTHBJblNwSC9kN3Q0QkpoZEsv?=
 =?utf-8?B?Vm1zUXJJQlBOQ1RKQWNRN3k4MFgvd2h6cDZSbi9UeWdUNlM5U29MdXhITXBW?=
 =?utf-8?B?U3JwS1M5azZhenFaVDVrYmlybEVKTjY4U2lZdnRhOVZLaFVJZ25lTFJsblln?=
 =?utf-8?B?N1NIaEtQU3E2K1RPQjlaNjVIQktBQWRWVmFWVDZ3WTZUNk9qTisrUTAzckIw?=
 =?utf-8?B?VWcrTFBmeXlXcmhYa0RPZTZvR3AvT2kwUGtGOHJWWEltUzUrVGZXbW1USGgv?=
 =?utf-8?B?YVo1dlhnR3lHZ2dHK1JBeEJ4TlYyWmdUb1d1cE9KVCtuWDRkT1YybnJPZW5u?=
 =?utf-8?B?TEZlWXBWOThBQzFJQjR6aitrTnhPNDEyL2VlWGtTeVJ0NUpEb1lmRSsyZHdU?=
 =?utf-8?B?SXpUdXhxeVprVlFvVXAxcVU1Q3dtbTZTbnJ0UXpsdVlNdDV0bTBuZmVHeWc0?=
 =?utf-8?B?NFE3anNnOUVPN1pJcXBZc0pnVjVJUklhNy9RQWJoQWZIamFIaVpYaFgvaTkw?=
 =?utf-8?B?Y1FTM2g0V0dsU3VDbUcyaDJzSmR3a3J2bUVOdDJYSmtwVmYzd0ZCNFBFdVVB?=
 =?utf-8?B?bWFSS3h4VW9KQVd3eHJsZXk3Vk53N1JoNmZKc0Vmei84VGpac2VTNlVybEta?=
 =?utf-8?B?Vk5NNlBlRENqcVcySEUzcTJBVngyd05zSjcrK09FaDk0NGxsZnBSRmdVZTFP?=
 =?utf-8?B?cDY5QTF2RVg4RFM4bUIvVERPb3krSEVPTmpQRldEc1F4cWdhbVJuZkNuNE1H?=
 =?utf-8?B?TVcwb3djdUZhTmdybXBJc2tQeUowOVBYakRZUDEzTjhFTFZDdU82UW5yRFpB?=
 =?utf-8?B?NDVoaE9PREptWXF1Q01ZT1dLUEpUMHcvRUZZSlZuT25sS1V0bXd3am1scnFp?=
 =?utf-8?B?cWJ4ME1XbkRHUnVKMVpGNjFjZkNmKzhid2dzME1hWHhBZmpXTW5jZHpBT1FW?=
 =?utf-8?B?dXdMcUx0U2ZvdjZyZlFPZ3phYVRhUXNrbTNKYlFiSHpydURWMUtha2w1UVJN?=
 =?utf-8?B?VGpuL2VNKzU3U2dlTGxGZzRzbitBa1BQUFliSGdzd0NwZ1h6blhOODlPbllM?=
 =?utf-8?B?VnFnTXNiSXU3SkdSbGxBQ2NsVDN4MlA4cmpRdmxYQy8xUFJ4V0Y2OUc1RDlS?=
 =?utf-8?B?bzZLWmxsRWtlenlJQ2RmeU5nNWlCK2JCSFEwL2M4ZjZ0UVp3cTM3Q1BTV2Jk?=
 =?utf-8?B?cFEvYUpZQ0tTZkhHdTFaNkw5OTltcHZxTTgzU3dlbTZsRHlvdG9FaEFnR05H?=
 =?utf-8?Q?aToXHyApzCMf5m7KdgBI7eA8S0zrku5A?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nm1RZmljalJxa2swQ0tqOGkyQWJJS2F3SWZCYkR3ejVGNWZkQW5jUWZjald3?=
 =?utf-8?B?bnVFK1dvNWVEakFWV1hZV3hnRDhtc09rZXhNZTVxUnZHQjVUY2dzait4K2dE?=
 =?utf-8?B?OEtDN3RTaDZ6UXNJMnRhZmoxTDA0b1dFYk1RNmE4ZXM5OEFUV0ZIdStBZ1VB?=
 =?utf-8?B?S29NN1Y1UnpuYzhScVI0Z2xHWFFZcjBVVmFMOGVIME0zb2RHVk5rb09xdXRm?=
 =?utf-8?B?SW9UTWxVZmtRWndzOTFPUWxsUGZoUU8wWG9uVEdOTjBiYm5BWDh3QnpXcW96?=
 =?utf-8?B?U1ZJQU4rdldxano4N0RYRUdkNE9yV2traEVONXBkQkpjZXFjL3FwdTRURTdK?=
 =?utf-8?B?THZNUUsxWXZuVlpONEtDK3NBck8wY1lGUW91Vk5ENE1EaTFiV0o2UG83WEhI?=
 =?utf-8?B?VXBMN1gvZnFmM2NWTFdBT056Q2s0WGVycm53UEZMS3JDTUg2cWNGQkRaME1n?=
 =?utf-8?B?M0JKR2VvZnJOS01IMk52L0xzcmtUcXROVis3UFpPaWRZUzZzRld3SVJuWEMw?=
 =?utf-8?B?WEJzODBJMmxjWnFVN1N3MDZzZDdkZ3hSWithUDBUQ2h3dHp0WFNpVHlUZlRj?=
 =?utf-8?B?V29tT3NPcmpSMFlFTnplZndzMXR5MldKTE1XbUpGYUgzMkRRVk9FbXY1OGdK?=
 =?utf-8?B?SjNjZng3cDVTTmdhSFkybXBKSktGengzMW5IYVIzQk1NOFQ4S1AxVWp6cHRQ?=
 =?utf-8?B?WG1rZnhleDVlT0tuYmZWNTMyQ1hMU0dQZit6VXdZa3pzTklSaUwySU0vbVd1?=
 =?utf-8?B?M3hvV0Z4M3owVEpzYmRmSjZ5Q1FUYzRiSjVXd3kybUYxNjA2ck1oSlRmaFJW?=
 =?utf-8?B?WklmT2VRYWxMaExFUVdpSENsYnE5RmxqaWNMN2dmMmhCL25XVTJjZWdkWHVJ?=
 =?utf-8?B?bDZUZkM0TU5WNE5abHNBWkdiK1V2SEliWC94OXNtZkg4QVpyamxNSWVNbVB1?=
 =?utf-8?B?Vlc0S1NIT0JVV3l5TzA1K1NndGJVZE5sYmlJNktNMHhLUVVac0hTcllnVW9p?=
 =?utf-8?B?KzcybEdKeGFGS0JNZHdPNHBwTW9aWG16R055VGNMNVkwajdBTDBQQ1R4MzBL?=
 =?utf-8?B?dHZGWEJtNVoxOVp3QnZ6UjBWTktsT0w0YTNWQVdtN2VBa2pHdTczSWdGYXdI?=
 =?utf-8?B?V0NsMjU4VE9nc1d1V3ErSGtIYzdUZy9JdnhDTmU0aEtldlVSY2xWTFk4djNr?=
 =?utf-8?B?WnhGZ3c2RE1XT3lTb0xJUVlibDJGOFMxYnJIekRvQ0F0Y2FvOEdsSStpNmlY?=
 =?utf-8?B?NzR0S0NqR3VHQTh5aFVpK0pGSXFmbG1vbGJWOVgxNHZ0TE1kcTBPVkMvc2dn?=
 =?utf-8?B?Y2g5TisweDdnTGg3ZnlrVUk3TWU0bjBjSFIzVFJLQ2wvcjBMZW45S01lS1hy?=
 =?utf-8?B?UnhCUWhZSHFnYjFRNVFIMjdLVnlmZlVhYzJBQnlpU0lBdS9NbG13bHVzR1JS?=
 =?utf-8?B?QU1tYkJORDJOWURWcmowTVNXTG5zdVVzanB2RkJFazhhN2x4aHhlZWYzTzdv?=
 =?utf-8?B?QkcwWDIzVDZyUFhBWVBJQnlka01lT0pJWEliSDlnUmZ6NzFvaGZseDBKRmRH?=
 =?utf-8?B?NnFZQTl3QkxZQ1ZvblZSbktWZTFRMlNza3JGWkozMUI5S2tTTCs4NysvSFMw?=
 =?utf-8?B?cVZIQzkvL2t3SjJwSFVPRjRWVXE3dFRtZSt6WSsxWlpNQkFTcXNiVmRCeGJY?=
 =?utf-8?B?NXpTZEp4L1J2RXNZZGdpYUZRbGMxVDlOSEpaTW85WHN4eXJ2WExPUWFnMm1G?=
 =?utf-8?B?alE0ZnBrZkFkTmkrRlV6THYwWUpLbTVnYXEyczJBN1BwdEdGNER6ZXI1T2t0?=
 =?utf-8?B?elVPbXF2RlVuRzNyU2daVUkxb3B5eHl1RUtmMkdDTGFzL01YbUw0cmY0VHd6?=
 =?utf-8?B?Vmc2RDhob1FjN0pnSlZjNFpleGY5K1pTMlN6Ry8xbm4yNWcwOHVycTljdmV2?=
 =?utf-8?B?am5IaDBqa2lzVVlmSzRSQUhEK0p4NU0zSWtLejBjbVFIS1liU2NKNW83cXNs?=
 =?utf-8?B?TllLN3VBaC8yS0RWYVJQNGU5YmllWDk5Z1NUYlFQVXVacXRQcnJCenpoRkdU?=
 =?utf-8?B?VXAvajVWd3djZkNrUkFGbjZCVnpiM3dpVmwzZ2ZWQllLWm5RVHlSREl5VnYv?=
 =?utf-8?Q?ws/Yniz2xc3oXftuPePWDwVEH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c31ace-04d5-44c1-5f01-08de10066a54
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 18:28:07.5654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWsmDOfTFtJIg1YnYkWGpsUw++hPpI59vf/fVdrkP0gUxa6wyJzcYcJrrBWVoRuEBUrQZl/FRhSFIvwDLKuwLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4458



On 10/20/2025 08:47, Borislav Petkov wrote:
> On Mon, Oct 13, 2025 at 05:30:40PM +0000, Avadhut Naik wrote:
>> +#define MAX_CTL_NAMELEN	20
> 
> Any particular reason for the 20?
> 
> AFAICT, the longest string is "K8 revE or earlier" which is 18 so 19 with the
> '\0'...
> 
No reason as such. Will change it to 19.
Do you have any other feedback on this set?

-- 
Thanks,
Avadhut Naik


