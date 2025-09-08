Return-Path: <linux-edac+bounces-4735-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0764B48453
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 08:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9646717AF72
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 06:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF66296BB3;
	Mon,  8 Sep 2025 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Iw87l6TO"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894C929E0E5;
	Mon,  8 Sep 2025 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313669; cv=fail; b=n3Zi1e60rJCV86vA9lQWYfHb+Tq6HCxDGjIdIVFZsB5MvIPZB5waNt44uBF2JmVr3xb3Mbs5c6OXabkorrYIbXyNOMtsTqDX86UZSU8hxgYDl6Df5Nm44DRCMI0HcUpDW2Cr19uts6iK21S+u5XKvYXfeIiI34xkgok/r54YsRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313669; c=relaxed/simple;
	bh=mwqtROTHawanzjNpT3xMvZshJfrqHwk2SLFZ+0wKggM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T+emqTDLdh4t1m4PHLA4Nen79Zetp9v1CetAbebaqz+qvioiXIjkZcBOubWqOQcm4lRj6ttPToLigwrzrsS4Zv+TNYJGvzYcuWSataUzaAU6BmNIOyDtUNHhcCg/7+2JAnkR/MNvD1ANaA31ieBCf4j/hKIFFoMN+0UofB/RfGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Iw87l6TO; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzcsyMGrmICQpK1d0QLUgJtz4OIsw/GnmHOXE23zyk5w4FxNx6MeGwyyaOXftMf72wLh/ycB1N2btFdO9tHl6gwZ/7nqYS4lLJZs4BsogknR0z5+YoDT6m0KWaXZDbJvZE0tJ+Z+jq/YsLvN1m9yrYZImX89Zo9R9DtP5iADS7XnqEtOwM7zCA9GZM8EESja3MQCix+3jLSVSAOWdppGUffwVbR8sWfGc9CJoulwrRuP6LJfooGDKnqooUPvqNoDcb2d8dN2DwaP+AaX4UayD8yn4zximg+Ra8bd2uyMxva5buy1iZ0fjDry3ZtfZAC4ccd7NPdowevYkaaw+eMReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwqtROTHawanzjNpT3xMvZshJfrqHwk2SLFZ+0wKggM=;
 b=FZVIq6H/v8CZZnp6UThBWcG7xBpTATkjElgEDMbPtP4beHoC1Xt9FICDG5OFDG4h1Sdk6gjhcengtSb4an9OFcxSNnVPRcDsC54cy9ln2S6HtsdPDBdmBTOpm6I7zfQ7lGwaAy5IDymLYJcQbhpzvqk0n9yhr4JDcXrKp1GFzaGRYrWe+hG00o/IPTZlxyvJZa+7i9w6U9Bo+rbOswoR2M5QiWfdtgGjms2IsduXyPTv6YLU3cfTLcS/cVzQ2HZp5s3Ff8QfJeyPiALgy53Uk8kKONwn6RTsj032hg/O5wkXmuEdoMqekuct9EPx1mqQVF49z1qtu30fYAfdwArveQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwqtROTHawanzjNpT3xMvZshJfrqHwk2SLFZ+0wKggM=;
 b=Iw87l6TOZUAmcMzIe8SwFGq6g6UnzEwPX3h4+Jw9qSwXyHNS1v3wFwD409KYq0g6KQx7tw3lBKnRMWETE56z6lFrJpj0MSuWErVb+HT9qwP9T5YuvZRC7IojJTDPD/3u+wiGE2t/wQDSXCUkQbjBqG5VhgK+O0vXn7VWsONf9uc=
Received: from SA1PR12MB8947.namprd12.prod.outlook.com (2603:10b6:806:386::7)
 by DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 06:41:02 +0000
Received: from SA1PR12MB8947.namprd12.prod.outlook.com
 ([fe80::8730:918c:b34b:d058]) by SA1PR12MB8947.namprd12.prod.outlook.com
 ([fe80::8730:918c:b34b:d058%6]) with mapi id 15.20.9094.015; Mon, 8 Sep 2025
 06:41:02 +0000
From: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "git (AMD-Xilinx)"
	<git@amd.com>, "ptsm@linux.microsoft.com" <ptsm@linux.microsoft.com>,
	"srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
	"shubhrajyoti.datta@gmail.com" <shubhrajyoti.datta@gmail.com>, Krzysztof
 Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Robert
 Richter <rric@kernel.org>, "Gupta, Nipun" <Nipun.Gupta@amd.com>, "Agarwal,
 Nikhil" <nikhil.agarwal@amd.com>
Subject: RE: [PATCH v8 5/5] EDAC/VersalNET: Add support for error notification
Thread-Topic: [PATCH v8 5/5] EDAC/VersalNET: Add support for error
 notification
Thread-Index: AQHcFkp+WKjPDiaVHUC8HUfghAuUvrSHpg8AgAFANHA=
Date: Mon, 8 Sep 2025 06:41:02 +0000
Message-ID:
 <SA1PR12MB8947C010FA7FF05F9980D983810CA@SA1PR12MB8947.namprd12.prod.outlook.com>
References: <20250826052914.2066884-1-shubhrajyoti.datta@amd.com>
 <20250826052914.2066884-6-shubhrajyoti.datta@amd.com>
 <20250907111948.GAaL1qVA_jL9F5piRR@fat_crate.local>
In-Reply-To: <20250907111948.GAaL1qVA_jL9F5piRR@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-08T06:25:51.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8947:EE_|DS0PR12MB6629:EE_
x-ms-office365-filtering-correlation-id: e91b5792-1095-4510-dfbe-08ddeea2ad94
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OFVuNjNGbkJ6bGJEcmU4eGFJV0J5QjVuaXF1T3d0Z2lJWFFCMHEwN1RjSlNK?=
 =?utf-8?B?VGZVQ0xXa1pyUGdENm5ZQVFuQ3dYY3k2ZlR0VmhibENJRmJKVll3REtodDg1?=
 =?utf-8?B?Z01FOWNxaUY5MkdueHV2Y2hCd0VOb2Z0MW5DNUZSd0swUzJCMTlid2R0MEhk?=
 =?utf-8?B?WDdLR3c3SnRJamFEdlVBRjVZSjJ1SEttQkhNWVQyQ0tydEdRS1M0QjFFYVVo?=
 =?utf-8?B?bFlma0dTaWVCVzdnZ2NBZHpOOFJ4aU9pQmRDak9OVEtGOUZ3V2R3M0tkTzNP?=
 =?utf-8?B?bitNWExaanMvWnNVWXQrUnJqd1MzMVlrcTQ0UXc0ZzVianQxYW43QVE1Q1JK?=
 =?utf-8?B?T2g1RE5PS08rK3VxMEdPcnJjS3g3OGZ2MmhZdHNucTlQMmpnVzV4SjBxMDRy?=
 =?utf-8?B?MGVNOFAxMFNFNU1nNHd0aTBJVlBXR1BtanM5MGljVUZ5dTN6NWxLdkRNeVhM?=
 =?utf-8?B?TGFRbUZtVVdZQVQ3RXc0Ulk5M3h0cks1M1kvNTJPK3hBU0E5VllsSW93OFgw?=
 =?utf-8?B?OEFabGdPcU5kZjhZRFB4eGJ4OUg2S3lFVzl6ay81RzVDM2RxTzVkRHJWZnpD?=
 =?utf-8?B?TXBvaEJ4aTdIOGdGTUxqTnpMSlpHSWp3S0dqUTZGaEZzZ1ZnSEdQQVJMd2tu?=
 =?utf-8?B?TzZZa2ZxTFllOXNzM1NUTWRCNE4wQTZocDRmVFZDL0hMNHp6NHh1U0ZtNEpm?=
 =?utf-8?B?SW5qKzlBbnYzR2w1NXN4V2lxSS9GKzVIZnhLeWV1dTd6dkVaZmwzd1diRHRx?=
 =?utf-8?B?SG1FeC9xbys0TThsZkxjM29nbTdjT0d1RllJcDVrUG5jSENacE9XNXRaRURV?=
 =?utf-8?B?dUNkbjYwMFhNYmg1REpralQ3aStSNlNqY00yVVhHMWkrRGNsMEJReFJtSkdo?=
 =?utf-8?B?aXNobFNVRFJBd0JKNVd5enRIS2lNSzZJRHAzUEgwQnNGWDRaNllydkh6T09Z?=
 =?utf-8?B?MlVSTDRBOFk5TUhTQWM2S1dVZHJnMEJnMWgveWFla2l1azRWOEtZMDBSdnhy?=
 =?utf-8?B?a2I2M29vV1NPS2hMUFkwcVBRMGNWdjZBSXo4cTk4eW9TTERobitXOUx3S0o4?=
 =?utf-8?B?M0dYOHRrTVlFMk5EYVdxNFlOSjRJR3hJNTRkRmtFenJDaHNwV2Q1LzNwc2s1?=
 =?utf-8?B?VHV1WGluOFZYSUF2THcvWXVjNjhaWUdPZ294K2UrZVZFanRLSzliYms3bDlQ?=
 =?utf-8?B?eVJQajJrL2hyYmtlckhmeGc5aWo0ZTBHNHIwSGRqRVFIYkh3bHB3YXpvNHo2?=
 =?utf-8?B?dURwU29XbDNoVGxDdDJWL3JhVWdQQW5PTlo2OEtGM2cyUUlzS0tXQm9DWmEz?=
 =?utf-8?B?aGE0dkdZVDF3YWUyUW1QV2U5c2xoRTltVkEvRlBCV05INnFxTVRCVVNIdS9q?=
 =?utf-8?B?aEt0Sy9TL2Jod21zNndmenB4Tk5vQ2NVLzhYVGJ3QW94YVFuT2pMQkJZRENj?=
 =?utf-8?B?OWMra3dVK2tHMEtET1g0MXo2ZmJmS1dCclVZSWtLU04zUGJLL2lYMmJaNEZV?=
 =?utf-8?B?QlpmTkhpYmZ1WHV1Um4yVk5mbmJLTml3cTdKMTBKRG1UdUp0QzdLZ3VGTmJS?=
 =?utf-8?B?ci82eExEV3ZoRTIrZGtZenFicGs0V2FpdDVTbU5EZ2xvTGFtbCtPUUdoZUNh?=
 =?utf-8?B?dnRaYW5pNG5ITkdQT2lJckZlNHl2Ukl4RVJHTG9FdGZNanQ3Tm10ck9GVkhB?=
 =?utf-8?B?ZkdYaUh6ZW51YnlCTytmRFJWM2tEcUZWS2E5Q1EvUkZGVkpEamZHOXk4cXZ4?=
 =?utf-8?B?Z1JveG9nRmVqcjUyRVJEak0wVW9uVFJBWW5PNWlGeS9LUVA0SEs5QzU5eGI4?=
 =?utf-8?B?ZytZWTM2amtGM3lyQWRCYUpZbE0zOGppeUthdkJHd2ZZOWlDZCs5a0JlV3FC?=
 =?utf-8?B?M2JraXo3NzVuYVd5RmlSWmRkK01abmdOcnIzb3FUZnpab0swVGd4RXZiZDVK?=
 =?utf-8?B?ZEdGU3Z3NUtaeTFJbmNqMWdicjZ1NHMvckpRYjRmOFFieUtuaE84UjdXWU5J?=
 =?utf-8?Q?hSxtVfaWJyo+9OecOmSfTTVixY3Qy8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8947.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEdIa256eFBHYXdvYzdBbDFJNGFaWm9UMWtqdFo5RzF0N24xZE52TXBIQ3Bv?=
 =?utf-8?B?ZXhsMUpsb0pDV0diYmEzSXFRR0h5MGlJbDI5cDBMQk9YM0c5NktZbDAzeklQ?=
 =?utf-8?B?SXZid09WVzJoWXlTM3o3dUV4aFBrZWVqRU1vWXdpa2g4djg1eEhORElteVF0?=
 =?utf-8?B?RTNvdkIxZ3dUUy9qVGlpOE14YldKenlDaTBuUU1aTnF3MDZsN1BtbVU2dTd4?=
 =?utf-8?B?MHJ4RnplYWVsVnVVL1g3ZlhXK1JWWU9zYkVrYnlTNTVaNWNYLzUyckl1eXR3?=
 =?utf-8?B?KzBmRElWU2xJQS9hcUJ6SVNOY0lINXJhZFRLSUtxM3lZRE1ScGFkYVZKQ0NL?=
 =?utf-8?B?SzVuSHhvZ0lzY3EyOXlMUWU3VmsxS2JTRmtiRVc2TldFOHM4V3hMbW5UaDg1?=
 =?utf-8?B?RHg5MjVLbzJwbzhZMm5kcENUdUlSV2MyZlhVRlN3dW9ZMDhvZEhEZ0xPN21V?=
 =?utf-8?B?a094UnNQWmVqUTlIYTZES0VETWJha25FbHJuUGVBN3M3UlNYNk9VMElremF2?=
 =?utf-8?B?UVI0aU5DYVAxQ2NoMVMrc2w5ekRZdHJiM25qTlpyRnBGbkhGbHVWS3VCbTR5?=
 =?utf-8?B?dW9IUlJTbGh2alhCVUJjdkRJOFVjMUZmejdPN0wycXVlVVJvSUpOM245N1Bn?=
 =?utf-8?B?ejh6VEErd24xdGpROUNMWUs4N1c4MEFhZmI2STlmcC8vMmlDZWRWbUd5amE4?=
 =?utf-8?B?SWp4a0wyVk01cnhhM293a0dUc0dxZXNGaFJtTHlHbUx0SnNnTEZlR1ZySitv?=
 =?utf-8?B?R0pTbjM4VGREQTB2WWZhaFdoakc0aEsrd3FVY3RNSnd6QUFna3lFekU4ZEZu?=
 =?utf-8?B?MDJyWm9pT1habG9uakI0b3EvNDFvVEJIY0VodEdBMHNGSkhnUWpYdGJPV1kv?=
 =?utf-8?B?eERSV1RUWEx1WGUwMkxCRFh1RXZSaG1PZVRSelRnbEY1RnE2eDRaMERGM2xq?=
 =?utf-8?B?YmFneGd2RHh6SHNBQy9VZEY5S1JoVjBMM3BjMytYbVVlYVVaRG9BVUdwT215?=
 =?utf-8?B?MkJpTEU1SG44emI0NHpxdE14ZzdJSndwYWhRQk4zdWF3MmFUZ1VBZ1NoWXhM?=
 =?utf-8?B?RTIyZ3VEWHhHeWwrQkFveWpPWmdUTmQ2eCtaV3FNdHhKN08zSldQTzRrNEkr?=
 =?utf-8?B?aHgrTDhmWlZnRm83MUdMTHRXeWtGSlhkeWVmbWlOcTlzaUFubllEcVdXczZy?=
 =?utf-8?B?K0VBWThmelVlU2gyVlpPdkZ0cUhzOFloaXZhV2g2R1lhNHlDTkEzbXBMKys2?=
 =?utf-8?B?K3NxMTZ4VDVSMnhPR0puaTFFNDdLK1lTc3kySktRREF4b3BMendyTCtkY3Vn?=
 =?utf-8?B?ZnJnblpoNU03ZXhxNXRFSEpzeWx4Nm9oQUtCTkVsOWxqY1ZzZnJzblNsMGNs?=
 =?utf-8?B?TkJwdmYvdjFqbit6cHFVQkZkNDM4TnZjRVF4UDcxQWswWHY5UzRtMENXbXp5?=
 =?utf-8?B?UTd1YnU3ZmVFOFRIQkdGaDUydnlkTWd2d0dRTnpvRGtja1pXYnI4Y1doWU82?=
 =?utf-8?B?THZFTkM2SzVhRkszL2piR2FFdThWU0YvRGZSY091TnhmekJtNTRoVUZvdGhs?=
 =?utf-8?B?WjFVV3ZXMXNFdVhlZS90eXIzSEMrYTVjRWY4dGR6a085ZEV2UFB6aTEyK0Uv?=
 =?utf-8?B?cGdjWUVieEE1Q0NseERmbUl1Y25ibU9DZGp3U3A1MkFBSEF2UWo2SDF4YnNY?=
 =?utf-8?B?WDg4SnRHY2NyWDVPU2dDdDFJZzFORkxhSzJ2UW95TTMzdUpCcGdSTUNDYktv?=
 =?utf-8?B?YjdLWTlqdS9UKy9SN25FVlZJMEhFaHNqQVk1Y2JHdElVUXhSK3IxQzdCUDQr?=
 =?utf-8?B?MUpwMEFqQ2RlbFdxaEhrOEZUTmlrSm5xME9yWUpvRFF0cmJmWGxnYXBIQnJs?=
 =?utf-8?B?K1FHUlUrSzE5UUF5NHgydHRudkQ4Slh6SXllNHhtMmpIcTcrNDYzSUJnV3Ey?=
 =?utf-8?B?bmRvR3J6NFptK2RWU21vbUlKREVMblgycFlaSFA4M29rN0FCbjZxdGRHWWZF?=
 =?utf-8?B?a1FybkovZVhMYWpraWdVemx0WHFlRDFyZVFLOXdOQ1BZbUUwKzRpZVlmQ21K?=
 =?utf-8?B?Z1ozN0VWSW9OYUlXVExmMUYraUlqcXYyT0tTL2JtMHpEbk5uRG1EYjFVczdZ?=
 =?utf-8?Q?7uqo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91b5792-1095-4510-dfbe-08ddeea2ad94
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 06:41:02.0653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KyFRs30BBLxavOUB/zpNmPyRZa2DVwFkGl3YZMuhHF1df1bb3KoC6fYmQBx09fDBKyvZJ0VPNYfaCRW6r+BcSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogU3VuZGF5LCBTZXB0ZW1iZXIgNywgMjAyNSA0OjUwIFBN
DQo+IFRvOiBEYXR0YSwgU2h1YmhyYWp5b3RpIDxzaHViaHJhanlvdGkuZGF0dGFAYW1kLmNvbT4N
Cj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC0NCj4gZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGdpdCAoQU1ELVhpbGlueCkg
PGdpdEBhbWQuY29tPjsNCj4gcHRzbUBsaW51eC5taWNyb3NvZnQuY29tOyBzcml2YXRzYUBjc2Fp
bC5taXQuZWR1Ow0KPiBzaHViaHJhanlvdGkuZGF0dGFAZ21haWwuY29tOyBLcnp5c3p0b2YgS296
bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+OyBSb2INCj4gSGVycmluZyA8cm9iaEBrZXJuZWwub3Jn
PjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgVG9ueSBMdWNrDQo+IDx0b255
Lmx1Y2tAaW50ZWwuY29tPjsgSmFtZXMgTW9yc2UgPGphbWVzLm1vcnNlQGFybS5jb20+OyBNYXVy
bw0KPiBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWJAa2VybmVsLm9yZz47IFJvYmVydCBSaWNodGVy
IDxycmljQGtlcm5lbC5vcmc+Ow0KPiBHdXB0YSwgTmlwdW4gPE5pcHVuLkd1cHRhQGFtZC5jb20+
OyBBZ2Fyd2FsLCBOaWtoaWwNCj4gPG5pa2hpbC5hZ2Fyd2FsQGFtZC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjggNS81XSBFREFDL1ZlcnNhbE5FVDogQWRkIHN1cHBvcnQgZm9yIGVycm9y
DQo+IG5vdGlmaWNhdGlvbg0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBm
cm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+IHdoZW4gb3Blbmlu
ZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9u
IFR1ZSwgQXVnIDI2LCAyMDI1IGF0IDEwOjU5OjE0QU0gKzA1MzAsIFNodWJocmFqeW90aSBEYXR0
YSB3cm90ZToNCj4gPiBBZGQgc3VwcG9ydCBmb3Igc2luZ2xlIGJpdCBlcnJvciBjb3JyZWN0aW9u
LCBkb3VibGUgYml0IGVycm9yDQo+ID4gZGV0ZWN0aW9uIG9uIEFNRCBWZXJzYWwgTkVUIEREUiBt
ZW1vcnkgY29udHJvbGxlciBhbmQgb3RoZXIgc3lzdGVtDQo+ID4gZXJyb3JzIGZyb20gdmFyaW91
cyBJUCBzdWJzeXN0ZW1zIChlLmcuLCBSUFUsIE5PQ3MsIEhOSUNYLCBQTCkgcmVwb3J0aW5nLg0K
Pg0KPiBPaywgdGhpcyBpcyB0YWtpbmcgdG9vIGxvbmcgdGhpcyB3YXkgYW5kIHlvdSdyZSBpZ25v
cmluZyBwYXJ0cyBvZiBteSByZXZpZXcNCj4gZmVlZGJhY2s6DQo+DQo+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3IvMjAyNTA3MDMxNzMxMDUuR0xhR2EtDQo+IFdRQ0VTRE5zcXlnbUBmYXRfY3Jh
dGUubG9jYWwNCj4NCj4gc28gSSB3ZW50IGFuZCBzZXJpb3VzbHkgbWFzc2FnZWQgeW91ciBkcml2
ZXIgaW50byBzdWJtaXNzaW9uLiBJdCBidWlsZHMgYnV0IEkNCj4gZG9uJ3QgaGF2ZSB0aGUgaHcg
dG8gdGVzdCBzbyBydW4gaXQgcGxzOg0KDQpJIGhhdmUgdGVzdGVkIGl0IG9uIGhhcmR3YXJlIGl0
IHdvcmtlZCBmb3IgbWUuDQoNCkFsc28gdGhlcmUgd2FzIGEgc3VnZ2VzdGlvbiB0byByZXBsYWNl
IGxvZ19ub25fc3RhbmRhcmRfZXZlbnQgYnkNCnRyYWNlX25vbl9zdGFuZGFyZF9ldmVudCBkaXJl
Y3RseS5bMV0NCkxldCBtZSBrbm93IGlmIHlvdSB3YW50IG1lIHRvIHJlc3BpbiBpdC4NCg0KWzFd
DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTA5MDExNTE2NTguR0JhTFc0NmliSnVm
NGtHZ25sQGZhdF9jcmF0ZS5sb2NhbC8NCg0K

