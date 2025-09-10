Return-Path: <linux-edac+bounces-4787-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF941B51C85
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 17:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ECD716204C
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 15:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6893212FA0;
	Wed, 10 Sep 2025 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U6vtLLDr"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF60A31AF2C;
	Wed, 10 Sep 2025 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519625; cv=fail; b=k0Bbq0EPws8ZzHUHcPpUr1EfyBLl1Kl5AI8kI4iv7joLDMWNLdOSSjfBZilhOn0EetxTG1sL+BsHlnvGmZIvSXrrMNLE4qeaabw5euvU60KlU/oiRkReYYApnsRAfTAlu8B7Y3Eml8uS/A7sBPQlcvGc8k0Z7vHFeWotisqCLmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519625; c=relaxed/simple;
	bh=xGnRwNYGHBf5uS+jiS4JMEPeL533MvdkJpLsIoOIdMY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GEPt5Ah98XC4EQgEoymPatLm4VEEvx08yz5ILYUywKtwwJh0AhKFO8e3U1IBncpzL/dJq5RKtp9hrV+5fxqLpAwvGPYwXuZwDo8jua9UnntHg6UybpbXl9y5wAajpFXC/f+b3zeuUjypiPYvdPGLwELUb+hI0+x17J199QXZyyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U6vtLLDr; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVMdSh96UCzHXuIYOP5cl+juXoYdbdIoCaDFogebaXgcXZSOLO93vZtssxA/8Y5QJmlGlwAiYCuX7g27P7b4FvqweWSQ63hiid0yx8T4TFApnureFykG9jgNzXzsqWu+yoLAozLITc6o0cr1B57tz5WqRykpOFDs7eJViAxE68P/CFOO96nGEXMMqa5GHUT7mM7EqFwdrQGAdxSfPljIgekA5Uv/tikRFqAPQIn2VpK4XNTVi8PuTjv6d7mPPbCDWd+4pcOwvFgaiqO/WHIp7WDiNJsZmS8Ca6VSJubM49bbbxOeIjQGpQYECuHgM6lSGCszjPMVwea9kJ20e4xXjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIwNBkyJ5WgfdmQ0Ocy+kI1Xz/ZMA+4RAskTVSq0gdU=;
 b=RqyhuD//ZHCTbpvKnEmEJEfo+TTUxfpu/r92QOLAab04QSvVyeFOwjkzPmEc+mvDkTvTBBUBfYLDO8aKNKVGAErPWDVBgGhvinBqpJrSN9rbMcMEIoRURAUe43v7x4kNy5TzFQC9JZAswQfCec8VVVmnOlsCqzWeo4RQNHboE9rsSFLL4Y7LmmtcUm5kbkOnHh+ePLU8JTJfc4JaF3WuZygFsJJqwHKy6EXiZ/cmxWY/Hxgzqfc9DAwGwQB9P6Qxjcve6YofCs56isd/NsFbem66/cLJP4zpTQ3PdnrHO+WH/jVO46vEkGhzt+B75lOY89ccOVOD2axlvQ681Y5eug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIwNBkyJ5WgfdmQ0Ocy+kI1Xz/ZMA+4RAskTVSq0gdU=;
 b=U6vtLLDrW1kmtG7s2IeWuiAc7s9yhy87mUjP3+mu6+NOxqwme4tKKWTAh2jnzPcZzJqe3Kc6b2Cv7jlsPimOLjkn2G3KxZNXz/M1B1eMju04PZOh4DWupVyvBx/JfE7VDt8bVw/CL0gb1/vSbzyhUwmuQ7ZYOB5/09D6rd8HhlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 15:53:41 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 15:53:40 +0000
Message-ID: <8186d0e4-14a1-4198-9a9f-8082f0b289b8@amd.com>
Date: Wed, 10 Sep 2025 10:53:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] EDAC/amd64: Generate ctl_name string at runtime
To: Yazen Ghannam <yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org
References: <20250909185748.1621098-1-avadhut.naik@amd.com>
 <20250909185748.1621098-2-avadhut.naik@amd.com>
 <20250910145108.GD11602@yaz-khff2.amd.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20250910145108.GD11602@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0149.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::26) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|CY8PR12MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6eefc3-db4b-4cd0-d6df-08ddf082367a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1V4TGtzVW44aGVLaVVwQVVpaE1QMzBBZFpjNXYzc3V6WDErMm1Wb2QzWDZl?=
 =?utf-8?B?d3pkQzdiRjFCVDIrYVl1VFRqWVJuS2FkN1hxcUluM2JoQUxGOFZYR01FN2VQ?=
 =?utf-8?B?c0pGcnN1VDQ5M2dkSFlDb3dWWW9pNTB5MVdPMGtoSDVhMXpmOUtNZGlPMTNt?=
 =?utf-8?B?WkQ5enY4bUNMekZXWXVsdVdVS1FoVFhrRVZ3UExvUXNGRGhEOVhIYWRyZ3kz?=
 =?utf-8?B?U21YMSs0Z2RKUEI2eEJLWHhISDJURnB4RXhXTHNmMjhuNW9YVHluMDRLMXl4?=
 =?utf-8?B?QXNyYXNwNWpPK211a0dIOGd4THduNk1EVVhkS0g3VzBDYlNsNEVYelpYL0dq?=
 =?utf-8?B?TjJpU1dKamh5WXdZNVFzNmptODNRdnAvSllwa0lOalJLczNRdE9DdHRRTGlX?=
 =?utf-8?B?a1VnN3Q3OWhydWdLTFh2ZjJEZ2EraHlja3lPZlBoUmVDbHdCTmQ3U29BUklU?=
 =?utf-8?B?OStJeWZZWmtVYk1hcUVHTWt2VktmTExBSlI2U3Q3WXY4cFk3RURnbkx5WlpD?=
 =?utf-8?B?SjRxL3lJeGtNdjY4VCtHc1lCSExLQ0ZJTkNCd3JMZW8rRjZWMnRuVk4reUJV?=
 =?utf-8?B?UzF2ZTE4YlcyK0w2aGNGRDg0UXhXK09xTGdUK2swWGRialpqczhqVy9QTUl3?=
 =?utf-8?B?dW1aVkRYK3g2dHM5MDRjaE5maW9pQk9pSDhmN05vMUREK1hha2UxVHBDeVNj?=
 =?utf-8?B?SHBTS0lLcERTa05BQVkzTVphUVlCY3RjRU1wRkFrY1lQM3QwTHNwOFR6TUZR?=
 =?utf-8?B?N0psc09kWTE0MFFEWnJOcjhrb3kwSEhGWDJzc25PN2ZkOFhrb3FPOXBCOVhh?=
 =?utf-8?B?Q2ZmK0NuLzF1MVFocFo2QmwvaUlyam1KSmhoKy9MeW84eTMvdm1xWkVhZEVh?=
 =?utf-8?B?OU5aSTFaZmV3VlNQUzhSeDNFUGJSQ1FCYyt6T2Z5Z3JneldHTWxpSk1tS3dp?=
 =?utf-8?B?MStXb2xSaHVFNmRYZ2gzU2o0WC9ObDIrNTg0Nm9mUkxFTFpSNDBxWERQb0E5?=
 =?utf-8?B?Y3hRNWc3T3pid0lXRG9jdm1wRHhTRWFaai9rdFo3bnlhcktPUnc5U3NqdFR5?=
 =?utf-8?B?T2RRS2pMc1gxNHMrOWJHRTJRUVB3clRUM2FqVUZmcnhQd2s1NDFMajdhdzd4?=
 =?utf-8?B?NEpVZmRxT1BvNzdPbElSd01pWXFBd0QzWDFMaEtacEdJSDZaQklud0tEZDly?=
 =?utf-8?B?WTJQd3hrcThJcGRTdlY5WWVGYzlBem9rYXJ1QnZjVHNXM3FzYndoRHBNaGhi?=
 =?utf-8?B?bnhqNHE1WVdQeHNqWGdyYjgyZ3JIZGtYWVlQeG51ZmpzMlJOckNnUkMzWUR0?=
 =?utf-8?B?bHppRzZkRndFMklRcHAvUjFhWVVoRC94bWdORDF1RGJ6elBicytjZFJEby9u?=
 =?utf-8?B?QWJDMS9WZ05vSWlMdk5hdGJXa2lpT3M1T3czT0J5cHRPbE43TG1uSytPY1Rr?=
 =?utf-8?B?dzRudEhNbXdLYnRBdjBSTnorNmhRV0ZBbGxxTklIT2hTd29uckZyNjg5WCtL?=
 =?utf-8?B?VDZVWmFBbklhRndxS2RXUWZXRWY3STZocFc3b0gvN1V3a2tpbVptNlpEbTY4?=
 =?utf-8?B?Vldnd2pDdzBiUlBoQ29MZUlyLzBzOG5ESXZ3T1BJczRzWUMzY1UwV2ovV2Z3?=
 =?utf-8?B?bkRlSVQ2d2VIRDc5ZHNwZldsOEdDTDZBWEFUSHh5VndkY2YxWG1wdDJEUFhJ?=
 =?utf-8?B?NUNhTVhDN2tabVY5VW4zMWU4c2pZcGJ4U1N4U1Z3cHdSOG5YdWVWWVBhVzRM?=
 =?utf-8?B?bGJHN2ZZZC9GNkkvcDVBeEEzZm9lZWxILzRTbFFQNUMrQUg4a0phaFZCNnZi?=
 =?utf-8?B?WjBleDlnN1B1d2FiVUdNdU1aLzFKVjdzSU05Vmo4dUJjQ3FHbDY2aTIwMlRK?=
 =?utf-8?B?cGlVcXpiNnNhZlZCQTFOb2JNWUUrSVUyMXBnczh5enY1L3NjVU5FeTRiMjNU?=
 =?utf-8?Q?E1psYpfrhBg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blQra3gxOUJQc2NlVFNaSzRHQVR1Zk9NQWN5RzdIUDcraUprSmMxWUdaY3Vj?=
 =?utf-8?B?UVhFNFBtaStIN1p3Z2VmZk5tV0czZFB5SHY0UnluNERVKzg1YlhlZ0FONDVT?=
 =?utf-8?B?Y2QySTNRMm9xZ3ExQVBNczlNODhyZDBwZjdRMHJMdklxSTJ3d3V4TVN0Tjc1?=
 =?utf-8?B?eTBQSklpNkNacnJKdjJuVTUzNUp0OVhvWlUwemhyQzdHSjRZdUxnakFveERN?=
 =?utf-8?B?TlpGUitXTFRiNmFraUdVYk5Wb1hHN1RvdlFzVEdjZVR4UWVmZUlndzB1aUpH?=
 =?utf-8?B?Y200YkthS0JVTTBteDZTZlUrV3ZjTU9YR2hQQnpxY1BWaWlhYytQMG90WCtp?=
 =?utf-8?B?dUx3MXh1WFR0L2FEM1c2eTBSNm0yZ0RweE55dDd0ZlhmQ2pFQ0lSWVhZOURt?=
 =?utf-8?B?L3lvUUZ6dll6K29wNnpJa2pWUmZPVk9Xa21NVDRmUmV3ekhKVXIwL2g4aTh4?=
 =?utf-8?B?ajNxS3ltUFNHYjNxU09mc200RGczZEJ2U0o2TDJVNVJFaUt0Mk9GUGkxSnRz?=
 =?utf-8?B?WjNxZWRoWmNmY1MwRWU2Tjc0ZkFwRkxXK0daUENKbFM0OGhCUVM0c2xOT0xl?=
 =?utf-8?B?bCszZzBNT3hWMEdkWTNieW9WQkdUaE1nZWlOL20vTlA4YkUvVG9mQUc4aFpY?=
 =?utf-8?B?Nk1nUzgzdEdSRW5KMnVoaW1NaUhWMjFFam9QejBPQmVkZ2tlOWFxUWl0MmFV?=
 =?utf-8?B?dGM5aEdPWGdlQ2FjbjI5WlVBOUdZWmh3Z1FYVzVuK3U5TE5GaWZldG1ZSXJn?=
 =?utf-8?B?LzdXblpTNnhxY0QrUWdzVVAzSDdoMGlBMjhUQ25wVUVYRjZuV1d3K3FkakxM?=
 =?utf-8?B?QW01b3dHM012TDdxY3VSY0owMitDR3Q1ME5ycFkxck9BYkpRK0dVYkVjazJq?=
 =?utf-8?B?cjRRU0J3SW9XYUtvOUwxb1ZOK0VnLzJ3R0E4UlQ4cEhBMmpTbmRtampWZkZp?=
 =?utf-8?B?QVBPVXZQMk1uYkZDcjlwN3NzRmxydWxRdWxURlNPQzJ4d0gzdGdoMTF3aTV2?=
 =?utf-8?B?VFAzSEhIU0grbE5vcnh3TFQ3ai83K3pvYUZmb0psUXhVSnZIK3h4aFRWeTZl?=
 =?utf-8?B?UDRnU2d1bmtoa1pyODBPZDVmNFVqSEpuMW9teVV2YWMrOEpCWVpDMlNxU3Fu?=
 =?utf-8?B?cDNCdzBNYmU5OG5CMXp0bVF6SXpQdlZsajNyYmpLci8zR2YyZ0E2SklJSXgr?=
 =?utf-8?B?QkJROWIxUVgyWjdzM1VSdFIvdnRNcC90N1ZzS3I1Qjl0eGRNWFo2bTliSXB6?=
 =?utf-8?B?RGZQRlo0c2VQMmdUWU5FdzVQZWt3Zng1cHQ0T0VNUS9xdU5hTzFsRkZ1ZlBG?=
 =?utf-8?B?Sy9SVTdER0xFVWxienN3UlN5SkxzWnRYZ29zekdmaUpsaXVhQUYzVFh3ck40?=
 =?utf-8?B?Y1lkd1F4NzAzUmNkSGUxbU83TjlFN000bU9EVzhKelI3blUzdXZOZlFQaGI4?=
 =?utf-8?B?L29iaEQzbWZrYVNNY1drakJXV2ZZQmpHNUEyS2IvQWpqYWVteHFRcVljcFkw?=
 =?utf-8?B?bGRuWmdvV0VRM0FGZEUxZEFmTWY1YVU2a1ZDL1JLaTljYWlRSlg1TXlIelM5?=
 =?utf-8?B?UVpqSHpKNGJOamVXbXV1ZFRiMzBzMmtTSjVyQ2tUdU5CYzZMM3VsKzZKM2NR?=
 =?utf-8?B?T04yZTRQWWxtRzBSVi95WjZqMUs1QmlBLzNWNlFPT3N4ZUVYUkp0bS9MR1ZU?=
 =?utf-8?B?UkxDN3hzSy84d0ZTNWpjV0c5RnpsbFZuVFhQVHRjejBpNmxKYU51L0Q5U1E5?=
 =?utf-8?B?c0dTak5FTU1LWXFPR092RVZOS0NONWFDcFNwTmtoaHVHYkhYS0U3SGhPR3Ni?=
 =?utf-8?B?U3BDNkRsYmxpRDVlWjUvUkw2UXFpMkN4cmZiRUJlQzU3NjJtZzg2WGkrRm52?=
 =?utf-8?B?TDQ2Y3FEb3JUM2NhSTBFMXZOZ3lmOGZoNmFtdDRyQS9Vb0FLbDkyMTVvVHRS?=
 =?utf-8?B?bWQvVWtnbklOQ3BLSk5DeE9zN25mZnZSU0xtcS9sZ2UwZHd0bXBYZ3ZxY3pN?=
 =?utf-8?B?VjQ0VjFXcmlpb1N3dEprK1RKaVpVRENhbW9ZeS9qMS9DN1JOVTVFUmpmV2hM?=
 =?utf-8?B?S1QrdDZkNERWM09LZnZ0QU94NXAxZ0N2VWhXUUFFbjE1UkpoMTFyQXVXRUMr?=
 =?utf-8?Q?NVE527uI1Z8mv1wEv570T5OaG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6eefc3-db4b-4cd0-d6df-08ddf082367a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 15:53:40.8362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJ25iR5jROX0nNxi3s1wPUS9GLcv6tgCm0tZcDo7Czi924RKG0idyYs5tj2aVfZpF3IQ0vDHV6vSGO2dIi/oIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489



On 9/10/2025 09:51, Yazen Ghannam wrote:
> On Tue, Sep 09, 2025 at 06:53:10PM +0000, Avadhut Naik wrote:
>> Currently, the ctl_name string is statically assigned based on the family
>> and model of the SOC when the amd64_edac module is loaded.
>>
>> The same, however, is not exactly needed as the string can be generated
>> and assigned at runtime through scnprintf().
>>
>> Remove all static assignments and generate the string at runtime. Also,
>> cleanup the switch cases which now become defunct.
>>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> ---
>> Changes in v3:
>> Patch introduced.
>> ---
>>  drivers/edac/amd64_edac.c | 44 +++++++--------------------------------
>>  drivers/edac/amd64_edac.h |  4 +++-
>>  2 files changed, 11 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
>> index 07f1e9dc1ca7..3989794e4f29 100644
>> --- a/drivers/edac/amd64_edac.c
>> +++ b/drivers/edac/amd64_edac.c
>> @@ -3767,6 +3767,8 @@ static int per_family_init(struct amd64_pvt *pvt)
>>  	pvt->model	= boot_cpu_data.x86_model;
>>  	pvt->fam	= boot_cpu_data.x86;
>>  	pvt->max_mcs	= 2;
> 
> Newline here, please.
> 
Okay.

>> +	scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), "F%02Xh_M%02Xh",
>> +		  pvt->fam, pvt->model);
> 
> There are a couple of special cases below.
> 
> So I think it may be better to move this part to the end...
> 
>>  
>>  	/*
>>  	 * Decide on which ops group to use here and do any family/model
>> @@ -3779,8 +3781,10 @@ static int per_family_init(struct amd64_pvt *pvt)
>>  
>>  	switch (pvt->fam) {
>>  	case 0xf:
>> -		pvt->ctl_name				= (pvt->ext_model >= K8_REV_F) ?
>> -							  "K8 revF or later" : "K8 revE or earlier";
>> +		if (pvt->ext_model >= K8_REV_F)
>> +			strscpy(pvt->ctl_name, "K8 revF or later", sizeof(pvt->ctl_name));
>> +		else
>> +			strscpy(pvt->ctl_name, "K8 revE or earlier", sizeof(pvt->ctl_name));
> 
> Maybe save this special case to a temporary "char *name".
> 
>>  		pvt->f1_id				= PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP;
>>  		pvt->f2_id				= PCI_DEVICE_ID_AMD_K8_NB_MEMCTL;
>>  		pvt->ops->map_sysaddr_to_csrow		= k8_map_sysaddr_to_csrow;
>> @@ -3788,7 +3792,6 @@ static int per_family_init(struct amd64_pvt *pvt)
>>  		break;
>>  
>>  	case 0x10:
>> -		pvt->ctl_name				= "F10h";
>>  		pvt->f1_id				= PCI_DEVICE_ID_AMD_10H_NB_MAP;
>>  		pvt->f2_id				= PCI_DEVICE_ID_AMD_10H_NB_DRAM;
>>  		pvt->ops->dbam_to_cs			= f10_dbam_to_chip_select;
>> @@ -3797,12 +3800,10 @@ static int per_family_init(struct amd64_pvt *pvt)
>>  	case 0x15:
>>  		switch (pvt->model) {
>>  		case 0x30:
>> -			pvt->ctl_name			= "F15h_M30h";
>>  			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_M30H_NB_F1;
>>  			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_M30H_NB_F2;
>>  			break;
>>  		case 0x60:
>> -			pvt->ctl_name			= "F15h_M60h";
>>  			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_M60H_NB_F1;
>>  			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_M60H_NB_F2;
>>  			pvt->ops->dbam_to_cs		= f15_m60h_dbam_to_chip_select;
>> @@ -3811,7 +3812,6 @@ static int per_family_init(struct amd64_pvt *pvt)
>>  			/* Richland is only client */
>>  			return -ENODEV;
>>  		default:
>> -			pvt->ctl_name			= "F15h";
>>  			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_NB_F1;
>>  			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_NB_F2;
>>  			pvt->ops->dbam_to_cs		= f15_dbam_to_chip_select;
>> @@ -3822,12 +3822,10 @@ static int per_family_init(struct amd64_pvt *pvt)
>>  	case 0x16:
>>  		switch (pvt->model) {
>>  		case 0x30:
>> -			pvt->ctl_name			= "F16h_M30h";
>>  			pvt->f1_id			= PCI_DEVICE_ID_AMD_16H_M30H_NB_F1;
>>  			pvt->f2_id			= PCI_DEVICE_ID_AMD_16H_M30H_NB_F2;
>>  			break;
>>  		default:
>> -			pvt->ctl_name			= "F16h";
>>  			pvt->f1_id			= PCI_DEVICE_ID_AMD_16H_NB_F1;
>>  			pvt->f2_id			= PCI_DEVICE_ID_AMD_16H_NB_F2;
>>  			break;
>> @@ -3836,76 +3834,52 @@ static int per_family_init(struct amd64_pvt *pvt)
>>  
>>  	case 0x17:
>>  		switch (pvt->model) {
>> -		case 0x10 ... 0x2f:
>> -			pvt->ctl_name			= "F17h_M10h";
>> -			break;
>>  		case 0x30 ... 0x3f:
>> -			pvt->ctl_name			= "F17h_M30h";
>>  			pvt->max_mcs			= 8;
>>  			break;
>> -		case 0x60 ... 0x6f:
>> -			pvt->ctl_name			= "F17h_M60h";
>> -			break;
>> -		case 0x70 ... 0x7f:
>> -			pvt->ctl_name			= "F17h_M70h";
>> -			break;
>>  		default:
>> -			pvt->ctl_name			= "F17h";
>>  			break;
>>  		}
>>  		break;
>>  
>>  	case 0x18:
>> -		pvt->ctl_name				= "F18h";
>>  		break;
>>  
>>  	case 0x19:
>>  		switch (pvt->model) {
>>  		case 0x00 ... 0x0f:
>> -			pvt->ctl_name			= "F19h";
>>  			pvt->max_mcs			= 8;
>>  			break;
>>  		case 0x10 ... 0x1f:
>> -			pvt->ctl_name			= "F19h_M10h";
>>  			pvt->max_mcs			= 12;
>>  			pvt->flags.zn_regs_v2		= 1;
>>  			break;
>> -		case 0x20 ... 0x2f:
>> -			pvt->ctl_name			= "F19h_M20h";
>> -			break;
>>  		case 0x30 ... 0x3f:
>>  			if (pvt->F3->device == PCI_DEVICE_ID_AMD_MI200_DF_F3) {
>> -				pvt->ctl_name		= "MI200";
>> +				memset(pvt->ctl_name, 0, sizeof(pvt->ctl_name));
>> +				strscpy(pvt->ctl_name, "MI200", sizeof(pvt->ctl_name));
> 
> And this to a temp name too.
> 
>>  				pvt->max_mcs		= 4;
>>  				pvt->dram_type		= MEM_HBM2;
>>  				pvt->gpu_umc_base	= 0x50000;
>>  				pvt->ops		= &gpu_ops;
>>  			} else {
>> -				pvt->ctl_name		= "F19h_M30h";
>>  				pvt->max_mcs		= 8;
>>  			}
>>  			break;
>> -		case 0x50 ... 0x5f:
>> -			pvt->ctl_name			= "F19h_M50h";
>> -			break;
>>  		case 0x60 ... 0x6f:
>> -			pvt->ctl_name			= "F19h_M60h";
>>  			pvt->flags.zn_regs_v2		= 1;
>>  			break;
>>  		case 0x70 ... 0x7f:
>> -			pvt->ctl_name			= "F19h_M70h";
>>  			pvt->max_mcs			= 4;
>>  			pvt->flags.zn_regs_v2		= 1;
>>  			break;
>>  		case 0x90 ... 0x9f:
>> -			pvt->ctl_name			= "F19h_M90h";
>>  			pvt->max_mcs			= 4;
>>  			pvt->dram_type			= MEM_HBM3;
>>  			pvt->gpu_umc_base		= 0x90000;
>>  			pvt->ops			= &gpu_ops;
>>  			break;
>>  		case 0xa0 ... 0xaf:
>> -			pvt->ctl_name			= "F19h_MA0h";
>>  			pvt->max_mcs			= 12;
>>  			pvt->flags.zn_regs_v2		= 1;
>>  			break;
>> @@ -3915,12 +3889,10 @@ static int per_family_init(struct amd64_pvt *pvt)
>>  	case 0x1A:
>>  		switch (pvt->model) {
>>  		case 0x00 ... 0x1f:
>> -			pvt->ctl_name           = "F1Ah";
>>  			pvt->max_mcs            = 12;
>>  			pvt->flags.zn_regs_v2   = 1;
>>  			break;
>>  		case 0x40 ... 0x4f:
>> -			pvt->ctl_name           = "F1Ah_M40h";
>>  			pvt->flags.zn_regs_v2   = 1;
>>  			break;
>>  		}
> 
> ...here.
> 
> Then check if the name was set already (by the special cases). If not,
> then set the generic family/model name.
> 
> For example:
> 	char *tmp_name = NULL;
> 
> 	if K8:
> 		if F:
> 			tmp_name = "K8 F";
> 		else:
> 			tmp_name = "K8 E";
> 	if MI200:
> 		tmp_name = "MI200";
> 
> 	if (tmp_name)
> 		scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), tmp_name);
> 	else
> 		scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), "F%02Xh_M%02Xh",
> 			  pvt->fam, pvt->model);
> 
Okay! Will try this out!

-- 
Thanks,
Avadhut Naik


