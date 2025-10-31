Return-Path: <linux-edac+bounces-5269-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04076C23AAC
	for <lists+linux-edac@lfdr.de>; Fri, 31 Oct 2025 09:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A70E14F5AC0
	for <lists+linux-edac@lfdr.de>; Fri, 31 Oct 2025 08:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3392D249E;
	Fri, 31 Oct 2025 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="vzomL5YG"
X-Original-To: linux-edac@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64AA285C8C;
	Fri, 31 Oct 2025 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897718; cv=fail; b=PJnjgmdoeuPzAtf1ieb+1y5J+8hw4+Mf6NDEpF5IFSUxN0Ul23dp3D4/HQ40geMPaIyQmeZ+tnogBeG+rLIiu++uQW97+X9HASoEKWv4xTv5Ur3VykYBA0xHKDZhzKCHZtp6CzCTxqUSZGgFhjvry76ihgETg1u9uajWF8LwbbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897718; c=relaxed/simple;
	bh=5CktXik2jKGAcX6JDW65yXbqacqUuUSFRo+BZN7c8w8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O2LZ6XFa07f7Ap7RzELg24zNmmGRxQ5yJvmAZ2wJADRZzUJnFJtNhPufcamci9Gx1HlgIOty8dybGY73hq05+iEJyhoz1+NXyegsJXNhmAZplY86QjhOlbLs38Cb9AcNIatd848uKqZFW/ZOg5POhV/7xPK4E5ZvwpqKq1hEBnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=vzomL5YG; arc=fail smtp.client-ip=52.101.46.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsdIkDAUj7QfkFwnmx+klyvenLQ0icoy4Z1IC56ymDbTdTDxZENZD10B/xn8CSaPva3ywAj0lc8obcHqkCUGCjQ90PypxsKAwz9kMzgnFcb6iALe+EEexDc1OsFIS9uJ9nf6+nga5il8Dd0ejh/L8BJylJABM7TmAjWxOyLg83+0vU/buj9OLIEF4DgqsCcCFaHdanB6QDcFd29Sr1yzgrLuxqJK/OQdpk1ZoxwQFiqeJqW12I0ub66vPyriw3nVBI4vAnwGJgn6WySu3a9QbSibfx0Z+oShXyLkyvLoLplqBv51fty5eW38enQm/YmrRTF1n/2JgLPB5ztjEFaP3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8N4berI6sw2hK8ppL+qxNpZbJ0B25XpbX/+lDoxTrro=;
 b=M/HY7IYCfFvwp8GzQgQtTSAJHgQ5BHDWCbdAWE+4SHm/OvMuBdG2cDUQ2UXLyA71lDvDBK1hwFO3PeL6PlYLh3280Ax4HtzSAaBbNFAYc5EGxn7z/BMN43mVQO8qX1y0UUsgj7d2laYCC6bdT6x4Wu40VoSv6PxFdCU+Jr4/vJoeYskD/PoG831KaI6NwcWR+k+Gw4hvg+wARNQTHXyx/IX3DYcbQsjFdW0Yx154bWFcq5hfidb6tXpm9pZr8asUQLSxSXPg/zjAK9U3T8mAxpK3GxoGkc1e8B7+tUlIgyUMslOexJWt26pteEq76wq9ocuK9jAVVYO9XJcuu2e/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8N4berI6sw2hK8ppL+qxNpZbJ0B25XpbX/+lDoxTrro=;
 b=vzomL5YGwav8iZCilAt+EJHMUzXj8fQyFd6suqioEJws8ux6og8e0b+ct4ymqxuhYWhGncFBBuaKWRFjfbWzMSNpNb7nORkN71dPgGCUDNuforsoEzWfBQh0ip+795Cqbz7bjWU+sfDo4HA8poCsdRnOy5YP5IyuDJTmA9rLlpTwrDWiqT+Z3cxDjCCScZGPb7bN7ZpKqJ/nG6B2iwjlIvB7yBGu60xEM7Zano7ScNutht9wp9AQKL1znQBxzwuoU9v5DqP1dKYoDOz1pE21ejSuNYDPplvV/xq38+qSr4yDwxfVPUGbU7c3dvrmXQ/fj45u6IlPWmiNzHJ/FHjXWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by SN7PR03MB7259.namprd03.prod.outlook.com (2603:10b6:806:2dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 08:01:54 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9253.018; Fri, 31 Oct 2025
 08:01:54 +0000
Message-ID: <aa390919-ef3d-4942-ac7f-59efb3f3c907@altera.com>
Date: Fri, 31 Oct 2025 16:01:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: edac: altera: Document additional ECC
 instances
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: dinguyen@kernel.org, matthew.gerlach@altera.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, bp@alien8.de, tony.luck@intel.com,
 linux-edac@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251028092232.773991-1-niravkumarlaxmidas.rabara@altera.com>
 <20251028092232.773991-2-niravkumarlaxmidas.rabara@altera.com>
 <20251029-adventurous-russet-jackal-64e3e5@kuoka>
Content-Language: en-US
From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
In-Reply-To: <20251029-adventurous-russet-jackal-64e3e5@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0062.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:23::9) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|SN7PR03MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 888e1b94-42f3-4f8f-cdc2-08de1853c154
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1F6SHdXZm5OZ2taaXlVYmFxLzNzVEk0UVVRN0dtYVRqT050OE44WFpVa1hp?=
 =?utf-8?B?TmxiRjNIRzNmNldrSytSUWdNVlZBTlZsMVp4RnhZSG8yVUxZdFNqUC9UTFFW?=
 =?utf-8?B?ckZ2VHpheDdzRVZ1dGhRRnRWYmorMWpoT2NvSXdPYVpPSHA5OGNuSGJ0b2JW?=
 =?utf-8?B?TUt0L1NWS0Y4MlBGK2dYbmE2M0ozMXJucTY4em5lZFp0TGhZdFBYWGtXODR6?=
 =?utf-8?B?VklPZmJkMC91M1B5TVFnMFU1MEpsZ1hwbk8ybWsrZnVWUDBybW5MOHJnUmZa?=
 =?utf-8?B?eEVEVmMxRWdGWDNWaXk5QXgxNjhseVZLWWpENFp2anFCcW1SUkVRMVVSR1J0?=
 =?utf-8?B?NDdGaWtUa2Irb2VZMTBLNjhscW9FOUErU29QQXJwWTNDZVE2MUhlSmdnRUtR?=
 =?utf-8?B?LzB2OUVvc2RyaVpGeVZlanRFVzdFby93YkFJZXB0WVJtVlVXa3Y1eHBhR1dZ?=
 =?utf-8?B?cTNxcm9xUDFXNTJwZEZRenBIblNDV0NFQ0lZMjAwcGhOeDJsbHpuTERobERI?=
 =?utf-8?B?ajhvRkFHZ3ZKc1FLQTFnUlcvRmR1Qm1tMUFRd1hFbnJBN1hpaUxPckxxaDI0?=
 =?utf-8?B?Q0g2ck1JQkt4YVIreFlWTlJVdVVBZ1o5a1lmQjNJWHpUeTlkWVE4SkxxZ3c4?=
 =?utf-8?B?SWlHWTYycXdmWlFlS3grYmpLTnd1UU9aQk9sN2RsOFBabG13a25OckhGZFgr?=
 =?utf-8?B?RlNhUjI2cXRQc1RwZUFCcldwS0RHamw3UmJJeUdyNVBNNkdpRVRwTHpFK1N5?=
 =?utf-8?B?WDhmL1pOVlNSSUxTVWlnTmxaM2VPTkl6ZEdvQzErM2ZwMERuTmNIVXN5THBa?=
 =?utf-8?B?QUphRzBFeXIxN3ZZT0xXS2hvcFdGV1N0MmZHbk1rSzhlRUxMM1VHa3hEY0NC?=
 =?utf-8?B?cmtSNXgwQkRna2xXbUhQbmdPSG9HVGZscGQrcmZxc3BpajNiUWhPTFFVbUJP?=
 =?utf-8?B?UVNXQUJSeGRBbXFBUWk4My9aOWo5ek5jdUxBM2ppakFtOWg2alpSaEtHU0sz?=
 =?utf-8?B?YmpCMVVyUXN6ck1VTjJsdUJXck9jSzJTRVBnOUdFaXJmYkpTd01WVWNUWXZI?=
 =?utf-8?B?eWk3TXd5NFRYOCszWldoR1FMQ1lTSEpCMUlNdXVGcU90UWx2V2tOZFErM2dm?=
 =?utf-8?B?UEUzb0JVZVdLekdycmlSNDFpRG45MThvblg4emJRNk1peTZScE1USVJ3ZXk1?=
 =?utf-8?B?ZFhmajdLekRJTXc4QWpGUFpjdGhBdE9ZZWkxWCtDYjhWZDVybEd4NXFBanM2?=
 =?utf-8?B?OFgyR2tjQmpSL2lxN2hHSHV2eUVUSVJRZTNod2dMUDRMWlhBaDdjY1dtWFBL?=
 =?utf-8?B?dWpNb2hxZmpteTF6SG1iekRPL2pZMUFBYjdoRDljc2UwT2oweGFqYUxrS2Vv?=
 =?utf-8?B?WEEwcVpYTnd6azZicGtpeGVRaXJoSXBDeDQ4NlorejVtZ3A0TW5WOUxNcEZ4?=
 =?utf-8?B?R3ZJb2VKVWdZYWFlMzRwbGVTTTd3ZHcybGN4UHpvdGRya1J5Y3AyZVRVVkFB?=
 =?utf-8?B?em1xV05QVGJKOVhrOHpiR1BxR3FpeVZjRWVTbVQzd3FXSGFueVUwNnVRUit1?=
 =?utf-8?B?Ynl1dUx3L24zTEt0Y3R6RmxLQkdteWpvalJaUlZmOVpqRlVMU0ZpOEtCSUJi?=
 =?utf-8?B?ZndabXg1Y3BUV3d1MTZyUG5IdkN4SmcwMG85Q1hsWTQvcGJBc2I4VnpqL2hN?=
 =?utf-8?B?dEQrVEFVUzlwand2S04rMWFVQXlvem5YbHhDVDBlb0RaRjhSWG83U0NrdENv?=
 =?utf-8?B?bURuU254OUVTNU5lbHVkL0NWdU9XRXovdHRxRys5djBnNVRmRUh3aHNCQ0c2?=
 =?utf-8?B?eHV2eTJpT1dsSVhrYU9DdktQOTIvR0VrWDIwTW9NNW40SlZqRWVnak1idDU2?=
 =?utf-8?B?RmJ1RTUwbEpDTlVVeWtVTk05WUdGUHhLK09zKyt4alVmR1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDBYUHVaWnRMdlNRVmhzcDE0TmdEbGNsMWlqc09vcld1M3lQWXhGK0lUUDdT?=
 =?utf-8?B?dUUxd2x2a1RMQkpYUWlmSVJzWVhCSEVYYXRjV3VHQUYyYTM1TzB1Y0tHVHhv?=
 =?utf-8?B?U29RaVJXZUNtQzhWaHU5UHdhSGVBbmRTWnZBY2srVmZWNVMrVll0cDlvRE15?=
 =?utf-8?B?VXRacEw4OERhSlYxQ2VBK2E4TS9yR1pzZlFnWWtXWWRsaTVtYTdnaTRVZXBh?=
 =?utf-8?B?M01HTG5DUFU0aDVCNnRvTTV4MEgyWkVVNzI4T3RabytwMnRmVCtjbFZieVM5?=
 =?utf-8?B?OWZFQjlOQm5WZDI5Uk5YYnMvQ0loVG5zejdYUGJGVkVadVgwZ2J5QTBzUFBM?=
 =?utf-8?B?NVg5WHlzTDVsVTR6d1RqSGdJQkJ0SjdiSlhHbFZoSmpaSmpFcmtXWlg3OVFV?=
 =?utf-8?B?TDBzTWFmM09QVUNKQWVVemcxd0FZNE5wSkFIY1NFd1hocjRWSlVxRzEzb3FZ?=
 =?utf-8?B?cHEyMHAyRWJJRDZlenlGMzd0VGkyMzRKMzQvTjN6VkN2aFNicldWYlJBVzJE?=
 =?utf-8?B?alZqaWFFVEt6MnIvejByL1l1L05IVWJ5dHc3RzZGWHpPUHBJd0EzaWcvZmVs?=
 =?utf-8?B?ZGhFWDBab2prZmpIcTFsTE1MbkJTZTVsU1VvV1IrMmU4UnE1c2xBRTRBTlVG?=
 =?utf-8?B?dEdJb2M2eGovZTc5WVp3dkxCK0ttRHpEM0czWVlqSFVaWnpnY0pONGgzS0Jz?=
 =?utf-8?B?blNibHorZnB3eGlqRVRlSTZkQjlmbGNQS1UxZjFJK043UENWZ3JxbStzZDF6?=
 =?utf-8?B?RDExQWRnM2NOQ3AyL0Q2UVA1OHQwc0p5bGVTcm5OeVZjdXNJMHpaeWxNMHdB?=
 =?utf-8?B?R0tEK3I1ellEdi9lUmN5dVJRQ3VVYUdqM21Pcm1TaCt1V3plM2dsSFdKaUdE?=
 =?utf-8?B?OEI4d2VjendRM0NSL0h0RXlOTkxoUkJWTi9MSVFURkpvV1BycnpZRWttQlpr?=
 =?utf-8?B?TGh2dURlUkVyMlY3OWJDQ3cwQ1JmeC9qTEdWRnRXcTlySzAwblcyYklkcldp?=
 =?utf-8?B?c2Z2WWxid0JWbTYrbjdWcWk5VzQrQ1kxU3VFTkx0RExtNkFYcjJVSFRuT1dt?=
 =?utf-8?B?YS9mc0c4SzdqRmgwbEE4ZTMzSm5vVnVVOStnTGVYYkNDYTBGUWtRSENpTjB5?=
 =?utf-8?B?YnlVM1NxQk5BcSswRXhVVU85c3NpYVBmRkk2VktpR1BHUHVvNlZxcmx6cXhG?=
 =?utf-8?B?MFlzWjFDWFVways2M2hiWjlEcUc4eTdhdzdYMjB1TlhPV3crYTRLNURXeENt?=
 =?utf-8?B?Z1h4VkRiMFFEMEVQd3NqY2tyTmFZbEttZzJLTE5wVXBOWi9XeVhJSHJhVlNk?=
 =?utf-8?B?NENkUHhxZVlOdDFXT3lNOVRROEc1VHUvR0dPc1R1MFBEbjhiWjQzMmpTVTM3?=
 =?utf-8?B?UEVKLy94TVIrbnVHQ2wwc1R2R25GOWN2czBrM2dyWEpaVzROY3c2eW53V21i?=
 =?utf-8?B?MWF0OTJxVEU0OXhpNjcxKy9rUHRybEJxTnY5cDByNkVXblVKT0ZSZzB2dGdE?=
 =?utf-8?B?N1ZyUkM5Q2Fxd0hyUVBHYkhSeFpEbi9PeEdZUnZVOTBCUkxVa2hVd0pkTlpi?=
 =?utf-8?B?eVhrdmFIUmt1TXhNUjJwbHdXQ01aNnhTZ1Ivc3YxS2ZTMm1uUEdaTVp3SVFn?=
 =?utf-8?B?UnpHL3orTjR2ZXZQbWVVcU44ajV6STF4V0lyL21yeEhnM1lkMmdleTlEbjBR?=
 =?utf-8?B?SFYvb0FydExXNDJyWnROYlJuME95ZFBrOG45R3h2TzZtc2FpYkZFZVBxTTd3?=
 =?utf-8?B?U013cDduY0JSZmlMTG5JdGRGVlVSZ2xmT2VMdVBBdmpRbTFYN3JJOXhaWXE4?=
 =?utf-8?B?YnRRTzRBRlMvSGlpQWtFYVZhVUZvYUQ4NWpPd1IrdUpVQWlWN1dSTXQ5Mk1D?=
 =?utf-8?B?THM5U1lzczNKOUFWeTg4eGxPbEtRVHk4SGdpemNITmhiUEI0dGxDT3hKWXpo?=
 =?utf-8?B?UmphdHhjaEY4aEh2WWVIOElLSGlCVm1nVmFsN2oyQ2pyQWpSenlOYlR2M1lE?=
 =?utf-8?B?cExxYW9Kc1FvMXl5RGxnekZyZXJ2dG1rVmpYMGRYaGFrYlJ6RFZ4Y2FWVVMw?=
 =?utf-8?B?QW92MUlyclNqbTdHbWowaFhnSm5vSEtLL2UxcU00dkFBMEttUmp2YU5hcGp0?=
 =?utf-8?B?TlROTkVQMDk3VmVlb3lwYTdhd1BQdUpTVUxJKzJaa2pENlRUOGZFaFBEeFBv?=
 =?utf-8?B?RHN2RFRvNlFlNTA4TFgreDNjb3lpa0hOZS9uaTcvN1NOWktIeHNHcUI5VWNS?=
 =?utf-8?Q?fpGIGNjMyqKK/1H1oVS2Z6xBljfvhkZwjBvOG+MN4g=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 888e1b94-42f3-4f8f-cdc2-08de1853c154
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 08:01:54.2075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmbdbOFN2u1+pcFxIaJJleoEYjaLfv+yt7lqDLdDQ7RAb4Lutd0GmM0RnLGt3xuAe+f8BHY5P9hlsyrvV6UHyEajEBFGrcPldccEhlkp7Xpua0cmlTM2gD/SfCp8wlEe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7259



On 29/10/2025 2:50 pm, Krzysztof Kozlowski wrote:
> On Tue, Oct 28, 2025 at 05:22:27PM +0800,niravkumarlaxmidas.rabara@altera.com wrote:
>> From: Niravkumar L Rabara<niravkumarlaxmidas.rabara@altera.com>
>>
>> Add support for Secure Device Manager(SDM) QSPI ECC, IO96B memory
>> controller ECC and Configuration RAM(CRAM) Single Event Upset(SEU).
>>
>> Add interrupt-names property and increase interrupts maxItems from 2 to 7
>> to accommodate additional interrupts.
>>
>> Signed-off-by: Niravkumar L Rabara<niravkumarlaxmidas.rabara@altera.com>
>> ---
>>   .../edac/altr,socfpga-ecc-manager.yaml        | 77 ++++++++++++++++++-
>>   1 file changed, 76 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml b/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
>> index 3d787dea0f14..5e0c08a15ab9 100644
>> --- a/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
>> +++ b/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
>> @@ -33,7 +33,13 @@ properties:
>>   
>>     interrupts:
>>       minItems: 1
>> -    maxItems: 2
>> +    maxItems: 7
> No, list the interrupts instead. Your commit msg must clearly explain
> why exception of not-fixed length/entries is justified.
> 
> See writing bindings.
> 
>> +
>> +  interrupt-names:
>> +    items:
>> +      enum: [global_sbe, global_dbe, io96b0, io96b1, sdm_qspi_sbe, sdm_qspi_dbe, sdm_seu]
> Nope, list the items instead. Please do not come up with some custom
> syntax.
> 
>> +    minItems: 1
>> +    maxItems: 7
>>   
>>     interrupt-controller: true
>>   
>> @@ -70,6 +76,41 @@ properties:
>>         - interrupts
>>         - altr,sdr-syscon
>>   
>> +  cram-seu:
> Missing description, so difficult to say what is here.
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2- 
> devicetree-basics.html#generic-names-recommendation
> If you cannot find a name matching your device, please check in kernel
> sources for similar cases or you can grow the spec (via pull request to
> DT spec repo).
> 
>> +    type: object
>> +    additionalProperties: false
>> +
>> +    properties:
>> +      compatible:
>> +        items:
>> +          - const: altr,socfpga-cram-seu
> Why do you need compatible?
> 
>> +
>> +      reg:
>> +        maxItems: 1
> So you created child node only for reg? No, fold it into parent.
> 
> You also forgot to update the example.
> 
>> +
>> +      altr,seu-safe-inject-ce-msb:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description: MSB of error injection command for Correctable Error
>> +
>> +      altr,seu-safe-inject-ce-lsb:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description: LSB of error injection command for Correctable Error
>> +
>> +      altr,seu-safe-inject-ue-msb:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description: MSB of error injection command for Uncorrectable Error
>> +
>> +      altr,seu-safe-inject-ue-lsb:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description: LSB of error injection command for Uncorrectable Error
> How are these board-level properties?
> 
>> +
>> +    required:
>> +      - compatible
>> +      - altr,seu-safe-inject-ce-msb
>> +      - altr,seu-safe-inject-ce-lsb
>> +      - altr,seu-safe-inject-ue-msb
>> +      - altr,seu-safe-inject-ue-lsb
>> +
>>   patternProperties:
>>     "^ocram-ecc@[a-f0-9]+$":
>>       type: object
>> @@ -191,6 +232,40 @@ patternProperties:
>>         - interrupts
>>         - altr,ecc-parent
>>   
>> +  "^sdm-qspi-ecc@[a-f0-9]+$":
>> +    type: object
>> +    additionalProperties: false
>> +
>> +    properties:
>> +      compatible:
>> +        items:
>> +          - const: altr,socfpga-sdm-qspi-ecc
> No, drop.
> 
>> +
>> +      reg:
>> +        maxItems: 1
>> +
>> +    required:
>> +      - compatible
>> +      - reg
> No point for empty children. One reg is not justification for having a
> child.
> 
>> +
>> +  "^io96b[0-9]-ecc@[a-f0-9]+$":
> You need to stop coming with random node names. Nothing explains why you
> need children, why these are not part of parent node.
> 
>> +    type: object
>> +    additionalProperties: false
>> +
>> +    properties:
>> +      compatible:
>> +        items:
>> +          - enum:
>> +              - altr,socfpga-io96b0-ecc
>> +              - altr,socfpga-io96b1-ecc
> Plus all your compatibles have WRONG format. See writing bindings and
> numerouse presentations - you always must use SoC specific compatible.
> 
> Best regards,
> Krzysztof


Hi Krzysztof,

Thanks for the review and feedback on the patch series.
I’ll go through your comments and address them in the next patch revision.

Thanks,
Nirav




