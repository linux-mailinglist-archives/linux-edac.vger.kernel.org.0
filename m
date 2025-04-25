Return-Path: <linux-edac+bounces-3714-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9A9A9BBE1
	for <lists+linux-edac@lfdr.de>; Fri, 25 Apr 2025 02:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 596964C2745
	for <lists+linux-edac@lfdr.de>; Fri, 25 Apr 2025 00:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB42139E;
	Fri, 25 Apr 2025 00:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="THwdw6m7"
X-Original-To: linux-edac@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CDEA50;
	Fri, 25 Apr 2025 00:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745541193; cv=fail; b=P4e0L99prfRhc5CNjZRhEygfg9WnEWKDZtMk9KuZ5GsS9Q5nEqdsfGgq9pKOWMFToRFNjUUCk0is+4wlnDkEOLXXjhHk2vlDwaUMVMJ7T84CYN0M42Cta1gduXEyscX7EhL9pC9Tqcit0HBDTKn11z17uFuJrdQrLRmBpQsKetw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745541193; c=relaxed/simple;
	bh=+F+qCP1MynGSU+S2x51JBgj0IhsNH/9flGBA+PK23U8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=omFtQfs5CkoOO8TUoigfgnHmxihXBNPn8wocmmZGsfr6lqNI07dIuIVgU/+dnK5tcwPLyZePm2qLoo3VTk3P3P2JrQBmuDMbJkyz8zauZ/oYemAF0dsqRYyW7pzaDIz+IPxMPtt6/oo10aEh/HOkC8VBZE5UWZOfdUgHKHxUNY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=THwdw6m7; arc=fail smtp.client-ip=52.101.56.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQxeCkK4SeesBpK3zGJgNRtg+N9KXVuP9Fqc34LFUZBsyMJ0GyPAfWH9cCbRCuLu8sh3VIJZJaBk7f/+GbR2QCZ+0vIA9iRUVpYIKlg2pdUtCg3S6qY5XJWMmlxJuEZcV+kfx/VnrtUrxNnOkZsYuZJm/p5c6qyuEsutY8AzKui6h6xcK4CTxk6OqOBQTjymLsEe5/ily4SNZOuRvyVkHcYHCeNpuS50+rKngUrex/WXOzcBbRPOUMjrrowKbzxLvHx5NTYZ4Gn4dR518q8eahi31aYy18gUuOQnF41ki1HZFAv3uPYScFeuDdIzrh7J9t7fZAoE3WNtNCWvMTPCrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyUXnvD6QP+gxRDOEyaStGPNczXq/lmby4FmSeEyiAY=;
 b=VnMcxE2KUId/KNsTBW/e6uBnj3q1kLe4H7xvOh6VofeaF7ASlmIQinWTIcchGLhxq1MVHepPdIYc5uAgw3NEMNkxg+GWJbHQ0e7K0OMBiio0JR0odqc/gIbZrNdOiJBKsemWkjG0kBhnmrXoe9cqoCh44Ajn6OBmftHuePZTgUgOtNaA/rGvY/RZUaEEwRJq6cEsWccKcKWTYGc0lJKrKYDDAHi/rtwPaDxu390x1Zk7Yfb4Q78/g7NueCcvNA0/j5Ocub17phu/oe870Cfa5InXO2VU+NeXidc/kHlsLdQrmL1TqSgaADY4kL9MlQ/XuFpIB90DLYsdYz6uazSWXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyUXnvD6QP+gxRDOEyaStGPNczXq/lmby4FmSeEyiAY=;
 b=THwdw6m7HqHA7bbn4HYkQEDxeyp993kwj5tV08TrCsMHDkA9fTGF5MaMBawoGilP8rjt07qXtNGdpB/VYVL5KfzGIW8Pp311LmOB+idLdPpPsiYq+dqrUg/oY5nHsj4pFeV6NbifDYgbFzDJY5tJEXbuv2fKua2tO79PA/1cqFbt6FOQkLhsbTnVTgTNxcK5Z48HPvsg8hOsWyC27BXVrPFaNEnNS7XBr9Bm6wnforfDkYwSx/xI1xpd2XI/Wzl6tAZMp1kg6gSGOaCrg699b7JQLSHredsJPhJnCmvHcAkzAwSXn5kKa7Irw1AGma1msV7AdWo72avhe1N37VTIWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by LV3PR03MB7729.namprd03.prod.outlook.com (2603:10b6:408:287::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 00:33:09 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%5]) with mapi id 15.20.8678.023; Fri, 25 Apr 2025
 00:33:04 +0000
Message-ID: <a518bc57-6fa4-4c3b-a037-8458a9510b7d@altera.com>
Date: Thu, 24 Apr 2025 17:32:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] EDAC/altera: fix cut and paste error
To: Dinh Nguyen <dinguyen@kernel.org>, bp@alien8.de, tony.luck@intel.com,
 james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
 tthayer@opensource.altera.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>, stable@kernel.org
References: <20250421161447.41886-1-matthew.gerlach@altera.com>
 <20250421161447.41886-2-matthew.gerlach@altera.com>
 <20e82d2c-b035-4bcd-82f7-807134101e28@kernel.org>
Content-Language: en-US
From: "Gerlach, Matthew" <matthew.gerlach@altera.com>
In-Reply-To: <20e82d2c-b035-4bcd-82f7-807134101e28@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0005.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::18) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|LV3PR03MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a06ff5-13f8-4f88-8ade-08dd8390b67f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVlrcTJESUtGTFAzZ200cU5jVDNwdDlkeHZRRzZQYWxyRVdmZ3VYVUJtaGlM?=
 =?utf-8?B?SitIbVg5aks4SnZnMExxbzN4QnpFWTJkbDV5cUpiTVBnTkE0OEtBYjAwaU4r?=
 =?utf-8?B?Yy92VHBxeS9QdnBqL0J0d3BsS3liRUtrb1NROERyT3E0Rmx5YkozRE43dTdx?=
 =?utf-8?B?V2pXcUU4cFp2WktjU1NZbEN4a0d2c0p2eHJMZXlwb1hyRXE5STFranJSejNK?=
 =?utf-8?B?Nk1uRVhWbGllZjg5Sk56cVJZdjFNTTd4K294QjNNUm1JVnNVcnNVakRwamNx?=
 =?utf-8?B?eW51SUpsT3RaWmN4ZnJHZmt3eUxGTFRkYmhYYTZkci96Mit4ZlN4R0tKWTJE?=
 =?utf-8?B?NzZ1am5SZDIrQ3R1ZmlXSXpGcGlwbDNBYVR6Q1hFYkJvMGFseHNpMzcrZmhN?=
 =?utf-8?B?SVFLbGQ4ZjVveDd6QU1rZ0tDb3dZaU96NkdRcDVTVWU1VDcxNTgrVlNTU1E3?=
 =?utf-8?B?d1g3bVkzMDJuMWxBR2NEeklVTFJvVXl2dnVhKzdIZFJHSjE3RS9OUnBMM2w1?=
 =?utf-8?B?aTVhclFjQVNKQTFlVERKT2NBVHhTSlhIR0RXZlh1VnFnaTc4dGNLaXd5QUUy?=
 =?utf-8?B?dERiV2c0WVdDQytuaDc3WDhPRkJuTE5yK1BxSnVQYzBKQnp0VnRQcDZNV0Vn?=
 =?utf-8?B?TW5PRDFMRk53MTk1bUljTjhnTmdUV1FEZ2RyNXhHRUZaZnBSNjRPWWo1Ym1t?=
 =?utf-8?B?Nkd4ank4N1FYQVdLL0JZS0xTQWZaUHBpS1pNbEdTS3liUVlzYUZaZmlmUGF5?=
 =?utf-8?B?dElMeTR4M0ZkY0N0azRyQVczdGorSllGQ2ZVRm1aTG5WQjJYUWQyWXhPWHVy?=
 =?utf-8?B?c3BIMjRrVzQvTE1ia0JKUE5hdDlZeU5JN1VISzc4MTVhbHVDc1dLT213UG81?=
 =?utf-8?B?MU4vdmZTMzFVenFNWW9PNDNYNzAyblBTUVpESGNRSk1xaU9OSFlyeEVvdHBK?=
 =?utf-8?B?bFljUmJpNU8yTkFRMEdudmtOTVhaYi9admVzQXc2N1pXMUtrV3ZvUVJoQktR?=
 =?utf-8?B?dVE3dWtQWnU0elJRUm1Eb0gwVkhramh6NnlwVEVRWU5WbnlsWEEyMXlWZnh6?=
 =?utf-8?B?bGFlKzN0N2d3b0IzNldwOTlReWRWRkkvWTJUQTAzWWp0cjdNRldrV0lBQ0l0?=
 =?utf-8?B?bzJxdWFlMDZ1Ty9TNE5rcElmUHJjUndWYStQVlpTMHNFeklza3pPSi9EWHNM?=
 =?utf-8?B?KzlvclNxZ1BuMnBuajE1V0FzK1ZNRFRKVnozL2RQVXJFdjM4NlEvUkpvS0Ja?=
 =?utf-8?B?MlBhbnIzV3JmSG1tTkN0alNDcnMzbG41Rlo0eldIRmppMDRmTDlQQklsZU9z?=
 =?utf-8?B?ZmlHYjUwZGhYczNDY1NLamZPbi9HTVBla0tzTW1WZm14dUJhMit3S1N0NkZ0?=
 =?utf-8?B?akVKNzdGaDFWTTVCYjYzbmRxbVJPYStYdjNrb2lGUmdLNS9tZHRUQ3BlaEUx?=
 =?utf-8?B?RnROVWNacWhSTUtCd3UwWnBiK1Qrd3NjajkwTGpUdnZ1b1hYbngxU2d5MW00?=
 =?utf-8?B?SmJPbVJtNWhJNnpmWEJGVTR6aDVlOEhtZ2hKb2w5TThPaFFMeGp4My9qU0RI?=
 =?utf-8?B?NEJRNHN2VTV3L1hkUC9rbEY2bjBUaTVUeE9TQUcvSmpHYUdnMGU1RE95U3Bq?=
 =?utf-8?B?bUJxR0dWZkdXL2VIU24vWXZMUU1WWTA0Nk5uN1l2TVVmdDB0K2ZCR1RYcXRx?=
 =?utf-8?B?OXFGNG5hajFhNFhrVnBKdHN4WXZwMktqT3hlZUl0Vm5KaTN4YklmenZaeVNv?=
 =?utf-8?B?cVV4d2NJbUpXQTJ5bW5qQXBIcFBzSjJqZGpLMHdCMVl4WFBuR0ZiRjB4eE1n?=
 =?utf-8?B?SjY2T0FjUU44ZWdYRzJ2S2U2bkdHOGF3aXgwOUMwMjVBa1g1YlhIN3Z2aWdC?=
 =?utf-8?B?RUFxbXZMSUZ2Z09hRmZCWG8rUjFCUTd6bEdBM1RsR1BTcTcreDVuWllFdFBa?=
 =?utf-8?Q?HtM+okKvjkI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amRjZEFvbFRmTytENHJ2NkxSaEZOL01ZL2h2OE5hQ1RFc3ZqRXI4a0c1eVJp?=
 =?utf-8?B?OFdDeUFtYkNvRWQ4Ny9tMGNydkZSTDBZQWVPWmdORldkd014eGE5c2FoNlcv?=
 =?utf-8?B?V1NCQzZESTdGL3ZBNVAxaE1oTmxPR0w1RXNTTmFNM3Q2TzdIWmRaK1VXdjFW?=
 =?utf-8?B?YThqcnZXMCtyV294YSt3OFlEdnllWjY1MXlWY2xUbkVDK01KM09qRk1ROSt0?=
 =?utf-8?B?UmU5QUluTDNVdk1vWng3NEhHUWtmZjJxbVpwWlRRVzZxRnZRY1hUQnhoS29a?=
 =?utf-8?B?ejArUXhyaEIrSnAvU2VoNFR4Y2JFSENZZU4yM1hZS3hYcU0xd2YzVnptakN5?=
 =?utf-8?B?Z0E0THdMQWRoSkFPMTZBMHdBTTlTK1hPRUg5RGIzc0tiMS9lak40UHVvbEdU?=
 =?utf-8?B?ekdiUDF3YkNhT1N5aDVOZHgwMUZteFc2NU1yQUZpUTFQVWpyMGxkMlg5aGNm?=
 =?utf-8?B?ejNKR3RVU1BkYkpzSTI2anJibElOa0xCN3l0UkE3L1BtUGFwVGFXWm5Wd1ln?=
 =?utf-8?B?clNnOGZIWnYycnZGYW52QXVxYkFLbE00ckd5ZXp4ZS9MMnBJNDR1dDZLdXZ0?=
 =?utf-8?B?d0p6Z1BmUFRxWi93ZGNBS0FUMkcyVldBL3ZNdU8zZnpKTXRLQXVKRDM0Y09J?=
 =?utf-8?B?YWdXK0JzU2xTYjJOalhNN1hkL3JLU2NsK0VNc3VCUFhEZFd6VmhPUTAySFhB?=
 =?utf-8?B?T3BYcnZlc1ZIcWNBVXcxR0xMVzlKenpXY1Q5TmgwMkFVWUlROEFjOGkxWDdr?=
 =?utf-8?B?QVphSE9pdEJHRUd6ckQ4dExzQmIvR0psblpLQ1VPMW5IVm1waHQxaEpaOHNr?=
 =?utf-8?B?bzZXR3RWUjluK2U3TWdEQ0x5RzFucnJxdVZyeGQxWFQvVTlaVWgvd1lzYXNM?=
 =?utf-8?B?SndST0NER1dvZ2VxUUlnd3k4dklvNFY3ZjVBcEpTVXFMZThBVjFPN0hZMXNF?=
 =?utf-8?B?aDVSamt1Zkt0SlU0dTBtdldsN0FodFpnRG5HdVdENHl6T09jcTdxYkREQ1VP?=
 =?utf-8?B?cDFTenNiTzAyamRVY2Vud2FuWVJZMXlQVlRqak5FT1RkeHh3T1ZYMjhUOUdo?=
 =?utf-8?B?UkRPTU9FNUpRRXRqZUJzYzdlME1YQTY4ZEZNZ2JyS2hRQXozbTdhU1Fxd0hK?=
 =?utf-8?B?RVlURjdVWUJIa3V3Rko2VEx2S2dlM05jV0tKYWVqY2tyMWovNE9aMXowbDR0?=
 =?utf-8?B?V2ZOQ3V0eDdwNzZlZkZpbVhXSld4OVBxMnYySUdsTFl6bjYzQmUxQUM5NjVk?=
 =?utf-8?B?cFdBbUxrZUJlcTNTRDVPYnZlaFNLQzB6MEwzUkNlWnk1bWNucW91ZENGOXg5?=
 =?utf-8?B?VFF5QS9WK2F5cWJLVnI2SFhQd1BFYm5ndDhIdHpnd3UycEZpUDVTSU9qcTJ3?=
 =?utf-8?B?RWdyNHBEUTRBUWM3RTRFcyttSEtwMzVXVU5yejFQK1hySmk1RVJlSklNdVJJ?=
 =?utf-8?B?Yyt3VkV4NGdHRjhHMEx6SlVzNkFnNVJ1NUVkOUVBNXpHejFBY1M1a0tXN0N6?=
 =?utf-8?B?VFBsVkhJL3huUUhxZ1lpS204VEpHYnpkMzlEZ0pUbnhkTXIzMGpuNnBxSWFP?=
 =?utf-8?B?VzBvUzRWZjZVbGlXQjQ1NU5uY1JGT0VYa2p1Qy9LZ0VBYk9qYzhneWpGTVl2?=
 =?utf-8?B?d2tiRDJHRnY1RW52S2szOXVtWmFBTFhaRVE4UmlVV3IwZG1FTnZ2amRLeFUy?=
 =?utf-8?B?VHQrS3NXblRrZUpFOS94aW9maVJmV3dYUzBBUGRZVTRFWlR5MHhlZmUxVnNJ?=
 =?utf-8?B?cUU5UEdHc3lYUnBQSzdsQnoxZExLU3dJZTFkellKc3Ftd3Z3blJUMktuSy9Z?=
 =?utf-8?B?bmJBVkhpeWtHS015VkVUaXVnOTVHOGxtMStzODR5eEhJZndYZ0VSdmNkeFZM?=
 =?utf-8?B?UjV2RU9Vb2hRS3AwR2JlV0JGb0Z5RW1PS2FOL0dmVEdudUFlK1RhdVhCUmJH?=
 =?utf-8?B?MStvTWdpUWRqR3hjYlgxOGdPYmNjYTFTN1RQVkt6cHVmVXhUWHU3RWdrTnAy?=
 =?utf-8?B?RDVUTm14dUphdDFFMFFIZnNSc0tGM2FvMDcxU0dUUGJEM0JLOGYzT0t4ejlT?=
 =?utf-8?B?LzRrVThhdnY5aEhtYnI4elhORXpYcHVZRCt3TmxTMmVVWURhaXdnN1hBTlpO?=
 =?utf-8?B?NkE0aU5kMHVTZHZoYVlyWkZnb0FGWERJQ0NzVjl3cnErMm84cGEyRU11cUtR?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a06ff5-13f8-4f88-8ade-08dd8390b67f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 00:33:04.5859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUXCrWx0AMn3u6WZFacy4IDAvd6f+WoPOiAYxoffWpZ1rcZhQnzsXrkYRBmFORUud4t2ABNtUmnECJdtzNeZN9kDBhbGbT2kDnyBuP7H+2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7729



On 4/24/2025 3:53 PM, Dinh Nguyen wrote:
> 
> On 4/21/25 11:14, Matthew Gerlach wrote:
>> From: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>
>>
>> Test correct structure member, ecc_cecnt_offset, before using it.
>>
>> Fixes: 73bcc942f4271 ("EDAC, altera: Add Arria10 EDAC support")
> 
> Please just use a 12-digit HASH...

I cut 'n pasted from git blame. I will use a 12-digit HASH for Fixes: 
tag in v3.

Thanks for the review,
Matthew Geralch


