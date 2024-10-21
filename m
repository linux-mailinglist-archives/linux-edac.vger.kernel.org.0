Return-Path: <linux-edac+bounces-2170-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDAE9A92F2
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 00:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF0C2814A4
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2024 22:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58F81E25F3;
	Mon, 21 Oct 2024 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LMKgdgaA"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7D52CA9;
	Mon, 21 Oct 2024 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729548446; cv=fail; b=N/qYMWavzRNzxvKnwX+wp4EkoYtLOcUzYnkmvdr7B8vtdj2NDSMuWfXqPZGXQ+NYyNsD4vzEpvFxcQjEPkELt7hY+U7H1kHmtS2jtZwySV0fktWb2rLKoTYZ6d1KQH5wh0XFLMIfhHUcXGK6KkoxYOQE6Cbquve7XWmGhxq7zSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729548446; c=relaxed/simple;
	bh=2co+WdMylemDJMzKZzU9zyoKAMfX4X9WMMaOEF7IyMI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L85e5jXdM1ulSL3inWBrCzT065OpwX8rEVyljYuMXat/nu0iHD0u4f0Zgw/zIVP/xGfbda9GG/Tlw+WO1KvgGSgKSMXgKP66OJTa25sHZjBd2aZ7Q1kMFfRgGOBKJJFUPMd5jVXSCg4DkAZrdQOG8lQbVeuFZY6hTGwwcsCRD+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LMKgdgaA; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSuiQffJqGtay4kbhy24x61uu+ErAxlMT+H6oD/tw9uPPI8X9NLD4ymyoHaSjRgBQ+KTqc2ByPqw81768op2nDtrytfrMGyBidFTceE17ZXgCu23777F7PxrGJaGnZO6E5qc0EoI+FwYs1X0iUSNYhH2VWfjqFBWcTqwj83BZnJhoroKpiSA4EDnGAMaSQq7vtGm8etRgi+46MNdbO/F60j46JXreA4rN+MlBF8bkdnKL0Cs0C+2CZtHb/ZkRhQgSA+wWULvvWA/7Vza4unupUQFer4ZczWOZbQr3AcZFK+n8xW/sWzvMPr40F26mh8wN7hFynvN0DYcfiKO9UF5PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2co+WdMylemDJMzKZzU9zyoKAMfX4X9WMMaOEF7IyMI=;
 b=tn5ZnsZcsV/Jlrbelm3O4zSCU66oA2fpdRnMunCI+GBi1SnscovmgE29qpOiNtJXhX7WQosRYr9D09PJ455zc1tWOmqLo+mVFWPXMYBshXCEV6Nl99ZP3C6O4w5H6rOP28xCUVmtv4uI6a2dEVrD2iFdpOWkyIRQpniq3bBhvVmZhXkwi4dIb51joHfWzzS75N6bkYzzqdv2L/CO0xyCM5jTQKIFFpQikwDasolzZc1tN08gDnEBSq4TLPIAch3To3m4Os99VlGMmXLq3Ho1hiHAcD8V6QjQlT35SSRn2PJOQSgDXKEc+t0mv6YGrQpcCN8mHhoEhG6HneSupwoEIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2co+WdMylemDJMzKZzU9zyoKAMfX4X9WMMaOEF7IyMI=;
 b=LMKgdgaAJ5G3uI+bWlbTvxfyNqyW3CK75F4/3hCrHv2v/+MgPICEz8YDO1W63S9K96pYjWCjViYxNt/FNeHb0AjgMiJ5KTnZt1Do9zQnhfwkCOQhC7oK8jPSekMwmsHUovY3h89LFyZarLaTheCtEC/uNwdTXVSPlQHh/PrIr7hKO+WrcQfE3K/u7/VW7h225T5S97RpmcYbiuy7npYIIUkCAzKmdo0Nq7tm55WclEPV5swU3Tn6n4XPkkEKqdLRJAh60OkIsp0eFXrTMqD0rrG7HHbPKiF82JGb+1PECA9HZogkRVt28T4l5SD6CE0UbPFxuDa+6kA4/KCLKWB/eg==
Received: from PH7PR12MB5902.namprd12.prod.outlook.com (2603:10b6:510:1d6::8)
 by DM3PR12MB9390.namprd12.prod.outlook.com (2603:10b6:0:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 22:07:20 +0000
Received: from PH7PR12MB5902.namprd12.prod.outlook.com
 ([fe80::f62:33c5:301d:edf0]) by PH7PR12MB5902.namprd12.prod.outlook.com
 ([fe80::f62:33c5:301d:edf0%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 22:07:20 +0000
From: David Thompson <davthompson@nvidia.com>
To: Borislav Petkov <bp@alien8.de>
CC: "tony.luck@intel.com" <tony.luck@intel.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"rric@kernel.org" <rric@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, Shravan Ramani <shravankr@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 RESEND] EDAC/bluefield: Use Arm SMC for EMI access on
 BlueField-2
Thread-Topic: [PATCH v2 RESEND] EDAC/bluefield: Use Arm SMC for EMI access on
 BlueField-2
Thread-Index: AQHbE0xecNMuwMISCkyzMjhkpIs8dLKK+XwAgAbp40A=
Date: Mon, 21 Oct 2024 22:07:20 +0000
Message-ID:
 <PH7PR12MB59022E4D59E610807572CCD7C7432@PH7PR12MB5902.namprd12.prod.outlook.com>
References: <20240930152030.11773-1-davthompson@nvidia.com>
 <20241017122816.GUZxEC4B04zA6YsCuS@fat_crate.local>
In-Reply-To: <20241017122816.GUZxEC4B04zA6YsCuS@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5902:EE_|DM3PR12MB9390:EE_
x-ms-office365-filtering-correlation-id: d171df2a-871a-44f8-f508-08dcf21cbc09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eGl1N1FjY3ROSktQRWRDTFQvay9SMjlUdzhmNWRLeSt5QWJHNVRwaU1GTXhZ?=
 =?utf-8?B?Q2xUM0tPdFJ3QTZmN2lOb3U5T3F6TVUrK1IrL2ZiT1RJK1JpMHhnd25JN3R4?=
 =?utf-8?B?MDVybXB2cVB1d3FVY2lhd0xHK3FndFpLVnM3VU1XQWExR2pJMkgwdVJKVHR0?=
 =?utf-8?B?MjU4R01hMFExbHJ3ZkJ0c1V0bHR3LzdMODF2V1ZlclhnTEJPVzhwL3FMbFdG?=
 =?utf-8?B?ZXRQdGZsNllEc1F0eExRRlMwa0tYbFdtVnNEZ3UzNzdIajJtYVo3aDhhRmlN?=
 =?utf-8?B?YVQ3Y1gzSnRKV21LRUVrSXFJaVpRYURjMTJNMGx2M2x0WE5Kbm1hc09xSWhC?=
 =?utf-8?B?bTEySG9KV3ljSE4vTzBQSm1LbWx4TWtaRlY3T0FFWTVySGZmR1h6YzBJNVYv?=
 =?utf-8?B?TUZqRlpiQXNNRzlVVXRIWlgva2liVXBpK2dGZGFqa1NyNTJEazkrVGp2OGpm?=
 =?utf-8?B?NzN2SE1qcllDZVIvTVJGaE9oUERPdkNLN2ViN1dNSHdSQ2lJUmNMZWJiTWZo?=
 =?utf-8?B?bzEvN2FkSUltT2ZLMjNCUmJnZ043R1poVFBtS2p0Yk5QaTJaOGJkcVBON2lR?=
 =?utf-8?B?N0NlbktJOHdRZUVQWG9uVzFsazFweWg1amRXeU85ZWt6cnJHVUJjOUpvd2RX?=
 =?utf-8?B?WkFzVld5WmxQYWM2VGhNajc1L0lFMGNNUk9pNGZRT2xVRFo2WnJxSndNRG42?=
 =?utf-8?B?VGtvNExQMVVDdlVmQkhZb0VQYjdqSHc3WHUwb2JueVd0bkVOMEloYmJtNGpN?=
 =?utf-8?B?MFh6eTJRNGd0bXVxWi9VekoyOXhSdEQwNnpBM3NxMWVrcEpVRGJyUEdrK0V3?=
 =?utf-8?B?QWRyelJMZGZyN3l6VXcwVmVwOVh6ZmdXbFZBdU1xbTNUaWxmSGN2aDh2VTNB?=
 =?utf-8?B?RHlsMnhMcWNYdWVHYkJQRElsV1NORUdIMXhFVWlQUHZscytsMmtac3luQVlL?=
 =?utf-8?B?dmVoZjI1Skc4SnJYZTdZNVFNbzJTR2QrVVM0Qk9PeERiZjQ4T1hBL0duRnZq?=
 =?utf-8?B?a0c4eDZOR1d5QWNidjhrYVJweUg2NkhPSHhoWHFhNDVhazZnd1g3YUs4NDBl?=
 =?utf-8?B?ZVh1Mk4ydWdEdWJVV0Q3MFVydWh3c0loRGtwNWtPTzZOeFNRTUNBTmtSejQ1?=
 =?utf-8?B?Y00rUFZGQUxWUkRzYmJnNUVmYjBDZjk5Q09QRXQ4a1BwUkFURkVyNjFwRFdE?=
 =?utf-8?B?L3dEb3YzZWx5enY3YklzQ28yc3V6c0UybFdVSnJjcncwd2p6ZDZTcm00T3hL?=
 =?utf-8?B?TFNPTnFzMjVMenh4bktFa2NpYkZlTi9MVmtTTFlmK0htVlF2UUQyU0Z2Zld4?=
 =?utf-8?B?WGZGVU5NWVF5VmRsd1dnTkhueVI0VkNSaERtVmFIRDN4UjVEWjZKS1IxK1Nr?=
 =?utf-8?B?ck83L2FNMktlbGc3ZG5iSjMyZmRBR2thV1lOMjlPZmRuU1NLK085UGZjY0Vw?=
 =?utf-8?B?RXA3UkdET0o0aXVUaVpJdEVDQkhhZ1l5cXRrMFF3MUpoaHJ3aVhpdWFUbTg4?=
 =?utf-8?B?MEkyZFg3VzlLZC9HODNEQll2OHp3MmY4alg2S0drRTc4MFdxVEZyd25ab3BO?=
 =?utf-8?B?K3pXMkswWlRKdkl3NmdsLzdPSnlyUnFDZFBmVzlHVGxiZlNPZ2dwQXJxV0ox?=
 =?utf-8?B?emZQODJrWEdwWWY1Uk5SWGtOYXA1WjdkazZNZVF4cTNxRHFTTDhnc1phUVB3?=
 =?utf-8?B?UytNbm90VkdKMFZJQURWTnJoam1Bekw3NDZjQkN2ZXY1bEI3bHczRSt0OE50?=
 =?utf-8?B?aCtIY0dsWEZvTkRKM0xoRHkzSUwzUEVyNVhoMTN6V3hYbkxqSzh6L3p6QVQz?=
 =?utf-8?Q?Rf/gYg2hg4rtMhXjIFD5Eh4oM9IbZvGf7UDkI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWkvN05NZWk5TVBmWStTdDBvc292cDlNVmRVTThEbEFLOHIxb2xlRGJnNk5R?=
 =?utf-8?B?dTdWUk9uMGdVL2kwRGlWT3RSYm9GZUdWZmd3WkU4amFWLzIvYW5hUjJXMjlt?=
 =?utf-8?B?S2I4YitUUndPeUtGSFdHaVdlR0JtWWlJcG5TL2NtSldVaDhuYUxtRW9OL1c0?=
 =?utf-8?B?ZjhiNEZuNkdLV0NuN3BuT0JWcmcwZy94TzJBTCsyWm9mZ29XT0I5bFFiZHhH?=
 =?utf-8?B?RUF0bTloenJYRzhCMWNiOWdkeXovNzRYcFFYL2JWZzJ4RitHMTdHb1Y1QUhU?=
 =?utf-8?B?ODByaGQxbHZ1d0VsZEpEY3NVREw2cllNRzVYTTFSWUtvN1JTbzRFd2V4WDVU?=
 =?utf-8?B?akVVS1ZNZXYwdk1uNGNMVXR6NkhnQlBIamVtL3hiQUFhdFhSZnFhS25tV2xF?=
 =?utf-8?B?bGtwd2tYWndJRTRIVlVZSCtIUHg4Wm1tR3YrNWFLTDhmWERiVVFyM3NlV0l6?=
 =?utf-8?B?RjcyT3VOd2JsbXNrZm0zcVZDWVZGUDhjQVhlTjAwWG9ROHgvMHlabzdwSHZx?=
 =?utf-8?B?NEJaNzRDa0xJVWZvZlRzVWt6dFhkWG9JMFdNYitBODJaSnBLcU5ER2w3cVFh?=
 =?utf-8?B?aHpPOE80eG9DT0t1ak5DMzFxUi84YWdYQ04wMm9qZUdQT2NOQmtjMkUwQnlE?=
 =?utf-8?B?NHllWTQwNVZhaW5yYVV6WDNCaEp0d3FkSVU2dXRlTk82VlVKczNwZmtSKzdR?=
 =?utf-8?B?Q3B3OTd5NmQzd29UZ3grMXhnUnEvRVFockdtRkxYMkJNVkhhU2lGS0k0QmIx?=
 =?utf-8?B?ZWZSU2hOTkozU1lvRU5iMXlKRHhPQSs4cWtZME1sV2V3b1laSWJzWFVPQ2t2?=
 =?utf-8?B?S0hQd2xNdnRlNHpLdk9WbTdON1BBRENOMzU1eWN6d2NMZjF6S1U1VzI3Ly9Z?=
 =?utf-8?B?NkVLMlRmYitFVStxNXBiZW9CenJOb1VJTVJOWGkwWFRzZTFxbXIwTWVxK0RP?=
 =?utf-8?B?VTRUQS94bkF3VkhvdFZsNGlWNzZ3cVd3WWpZaVZleHQyOUlHUTZLb3RwMm42?=
 =?utf-8?B?VTV6eC8xNVlhMy9CaVZoYm5hdk1XQXQyckx3OStsWlJQanFUZ2VMbGFoT01L?=
 =?utf-8?B?QXNLVXIyamJYQllWTktyOVJkaCtzMDhjWTYzM0ZlNHlNRWRSMEg5TkZUbk1I?=
 =?utf-8?B?NjJqU1ArMWxOMnF6Wk1wKytiWjBKTGFRMTd4WEpNUTdhQWYxK3krcDE3L0Nm?=
 =?utf-8?B?TXUya05GMkJRQnIvN3J5OFlUZmcrcDlaVGtEa01IdXJkbDJjYTg5c3RuOUxR?=
 =?utf-8?B?NmtDeUVUTDRMQXQvUFlROHFTNnk2KzNPQ0kxeFMvT01Sd1FBZ0F5Vm1WckVZ?=
 =?utf-8?B?dDZQU2x6ejBpMGhEOE9HT1M4N3QzTlE4ZWZnQTRkMmhHdHlpOElwam9ieTR4?=
 =?utf-8?B?QlhWT29rUEE2cllEdUdzQ1VlZTlOYmN2QmFVdU9mZlh3d21BamR4OWxpdWd5?=
 =?utf-8?B?azc0L3BWZUxVQSsxekJrRDhJQmQvR2dRbmdZOXFzVlNIbmdhNEhFbVhaWVhk?=
 =?utf-8?B?SzVkbkF5eHY1K3FMZ3cwY3ZCMldoeFFUOFZ2Ny8vYnJHMExhOXhObmxSak9J?=
 =?utf-8?B?VVhrSHdTeldLSUJPTjdBWjVkcllRUmZyY1lTQVFxcThqZlV4bmRNc0w2cUlT?=
 =?utf-8?B?TlN3VWdnbE5GSzM3ZTJqUGw3azVRRXg0cytZajI5dDYzRm92VTJDMW9KUVJ4?=
 =?utf-8?B?aDU1QW0ya0tZWDZVN3hERW5FUnZwQmovMEdEUzVBZExJZktNWjVnTWlta3JC?=
 =?utf-8?B?bGRWTXM4eGJqdDlMeER4dUxMQlhXVlNlOTZKR0VQa1dMK1ZTYVNIemtBR2lM?=
 =?utf-8?B?TzJVTXRIS0NxUnNVcFBvZFZ1Qm9lOW4rTXhpZ3hEdHViSHhtZHd5RWpVamRt?=
 =?utf-8?B?c3RieGtBTGFaTWpuUTVhWEhuRG9yNWdPc3J5TUw4WDdHOXpBcnhKckc2UjEy?=
 =?utf-8?B?eW0yZDdqTXpMOWU2dXhzUEtvbUxBL2xaTTEwTy9vWGNKOStKWlJIY1FoWmJ0?=
 =?utf-8?B?K2dQTU1nZHNqQ0dPUTloL0JHUktlcmJEMTBSaVJyQjZ1QUpBamVvUEh1TDNn?=
 =?utf-8?B?b2dWZGlZQW03dVZhWnhrOE9CTE9vQjFjaG96S1VlNmF4ZVp0V3JSKytUOHZX?=
 =?utf-8?Q?lgiq8/L9ABFk/M9QK1hfbJczA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d171df2a-871a-44f8-f508-08dcf21cbc09
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 22:07:20.6966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y9AUvj+v7L6j9VQNRw0yMNddLsCV4tgCqMPkN3jS2dh6mY4wbT9rrlkdKgEthCwNW27FWGaKAsVxJpzFh1rjgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9390

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMTcsIDIwMjQgODoyOCBBTQ0K
PiBUbzogRGF2aWQgVGhvbXBzb24gPGRhdnRob21wc29uQG52aWRpYS5jb20+DQo+IENjOiB0b255
Lmx1Y2tAaW50ZWwuY29tOyBqYW1lcy5tb3JzZUBhcm0uY29tOyBtY2hlaGFiQGtlcm5lbC5vcmc7
DQo+IHJyaWNAa2VybmVsLm9yZzsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IFNocmF2YW4g
UmFtYW5pDQo+IDxzaHJhdmFua3JAbnZpZGlhLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiBSRVNFTkRdIEVEQUMvYmx1ZWZpZWxkOiBV
c2UgQXJtIFNNQyBmb3IgRU1JIGFjY2VzcyBvbg0KPiBCbHVlRmllbGQtMg0KPiANCj4gT24gTW9u
LCBTZXAgMzAsIDIwMjQgYXQgMTE6MjA6MzBBTSAtMDQwMCwgRGF2aWQgVGhvbXBzb24gd3JvdGU6
DQo+ID4gVGhlIEJsdWVGaWVsZCBFREFDIGRyaXZlciBzdXBwb3J0cyB0aGUgZmlyc3QgZ2VuZXJh
dGlvbiBCbHVlRmllbGQtMQ0KPiA+IFNvQywgYnV0IG5vdCB0aGUgc2Vjb25kIGdlbmVyYXRpb24g
Qmx1ZUZpZWxkLTIgU29DLiAgVGhlIEJsdWVGaWVsZC0yDQo+ID4gU29DIGlzIGRpZmZlcmVudCBp
biB0aGF0IG9ubHkgc2VjdXJlIGFjY2Vzc2VzIGFyZSBhbGxvd2VkIHRvIHRoZQ0KPiA+IEV4dGVy
bmFsIE1lbW9yeSBJbnRlcmZhY2UgKEVNSSkgcmVnaXN0ZXIgYmxvY2suIE9uIEJsdWVGaWVsZC0y
LCBhbGwNCj4gPiByZWFkL3dyaXRlIGFjY2Vzc2VzIGZyb20gTGludXggdG8gRU1JIHJlZ2lzdGVy
cyBhcmUgcm91dGVkIHZpYSBBcm0NCj4gPiBTZWN1cmUgTW9uaXRvciBDYWxsIChTTUMpIHRocm91
Z2ggQXJtIFRydXN0ZWQgRmlybXdhcmUgKEFURiksIHdoaWNoIHJ1bnMgYXQNCj4gRUwzIHByaXZp
bGVnZWQgc3RhdGUuDQo+ID4NCj4gPiBPbiBCbHVlRmllbGQtMSwgRU1JIHJlZ2lzdGVycyBhcmUg
bWFwcGVkIGFuZCBhY2Nlc3NlZCBkaXJlY3RseS4gSW4NCj4gPiBvcmRlciB0byBzdXBwb3J0IEJs
dWVGaWVsZC0yLCB0aGUgZHJpdmVyJ3MgcmVhZCBhbmQgd3JpdGUgYWNjZXNzDQo+ID4gbWV0aG9k
cyBtdXN0IGJlIGV4dGVuZGVkIHdpdGggYWRkaXRpb25hbCBsb2dpYyB0byBpbmNsdWRlIHNlY3Vy
ZQ0KPiA+IGFjY2VzcyB0byB0aGUgRU1JIHJlZ2lzdGVycyB2aWEgU01Dcy4NCj4gPg0KPiA+IFRo
ZSBkcml2ZXIncyBwcm9iZSByb3V0aW5lIG11c3QgY2hlY2sgdGhlIEFDUEkgdGFibGUgZm9yIHBy
ZXNlbmNlIG9mDQo+ID4gdGhlICJzZWNfcmVnX2Jsb2NrIiBwcm9wZXJ0eSBhbmQgZW5zdXJlIHRo
ZSBtaW5pbXVtIHJlcXVpcmVkIFNNQw0KPiA+IHNlcnZpY2UgdmVyc2lvbiBpcyBwcmVzZW50IGJl
Zm9yZSBlbmFibGluZyB0aGUgQmx1ZUZpZWxkLTIgc2VjdXJlIGFjY2Vzcw0KPiBtZXRob2RzLg0K
PiA+IFRoZSAic2VjX3JlZ19ibG9jayIgcHJvcGVydHkgaXMgb25seSBwcmVzZW50IGluIEJsdWVG
aWVsZC0yIEFDUEkNCj4gPiB0YWJsZSwgbm90IHRoZSBCbHVlRmllbGQtMSBBQ1BJIHRhYmxlLg0K
PiA+DQo+ID4gQWxzbywgdGhlIGJsdWVmaWVsZF9lZGFjIGRyaXZlciBuZWVkcyB0d28gY29kaW5n
IHN0eWxlIGZpeGVzOiBvbmUgZml4DQo+ID4gYWRkcmVzc2VzIGFuIGlzc3VlIHJhaXNlZCBieSBj
aGVja3BhdGNoLCBhbmQgdGhlIG90aGVyIGZpeCBwcm92aWRlcw0KPiA+IGNvbnNpc3RlbmN5IGlu
IGRlY2xhcmF0aW9uIG9mICNkZWZpbmVzLg0KPiANCj4gRG8gbm90IHRhbGsgYWJvdXQgKndoYXQq
IHRoZSBwYXRjaCBpcyBkb2luZyBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgLSB0aGF0IHNob3VsZA0K
PiBiZSBvYnZpb3VzIGZyb20gdGhlIGRpZmYgaXRzZWxmLiBSYXRoZXIsIGNvbmNlbnRyYXRlIG9u
IHRoZSAqd2h5KiBpdCBuZWVkcyB0byBiZQ0KPiBkb25lLg0KPiANCg0KSGVsbG8gQm9yaXNsYXYs
DQoNClRoYW5rIHlvdSBmb3IgYWxsIHlvdXIgdmFsdWFibGUgZmVlZGJhY2suDQoNCkkgaGF2ZSBz
aG9ydGVuZWQgdGhlIGNvbW1pdCBtZXNzYWdlIHRvIGluY2x1ZGUgdGhlIHJlYXNvbiBmb3IgdGhl
IHBhdGNoLA0KYW5kIGxlc3MgYWJvdXQgd2hhdCB0aGUgcGF0Y2ggaXMgZG9pbmcgLiAgUGxlYXNl
IHRha2UgYSBsb29rIGF0IHYzLg0KDQo+ID4gIHN0cnVjdCBibHVlZmllbGRfZWRhY19wcml2IHsN
Cj4gPiArCXN0cnVjdCBkZXZpY2UgKmRldjsNCj4gPiAgCWludCBkaW1tX3JhbmtzW01MWEJGX0VE
QUNfTUFYX0RJTU1fUEVSX01DXTsNCj4gPiAgCXZvaWQgX19pb21lbSAqZW1pX2Jhc2U7DQo+ID4g
IAlpbnQgZGltbV9wZXJfbWM7DQo+ID4gKwlib29sIHN2Y19zcmVnX3N1cHBvcnQ7DQo+ID4gKwl1
MzIgc3JlZ190YmxfZWRhYzsNCj4gDQo+IFNvbWUgY29tbWVudHMgYWJvdmUgdGhlc2UgbWVtYmVy
cyBhcyB0byB3aGF0IHRoZXkgYXJlLCB3b3VsZCBiZSBnb29kLg0KPiANCg0KdjMgcGF0Y2ggd2ls
bCBpbmNsdWRlIHNvbWUgY29tbWVudHMNCg0KPiA+ICBzdGF0aWMgdTY0IHNtY19jYWxsMSh1NjQg
c21jX29wLCB1NjQgc21jX2FyZykgQEAgLTg2LDYgKzk4LDcxIEBADQo+ID4gc3RhdGljIHU2NCBz
bWNfY2FsbDEodTY0IHNtY19vcCwgdTY0IHNtY19hcmcpDQo+ID4gIAlyZXR1cm4gcmVzLmEwOw0K
PiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGludCBibHVlZmllbGRfZWRhY19zZWN1cmVfcmVhZGwo
dm9pZCBfX2lvbWVtICphZGRyLCB1MzINCj4gPiArKnJlc3VsdCwgdTMyIHNyZWdfdGJsKQ0KPiAN
Cj4gRm9yIGFsbCBzdGF0aWMgZnVuY3Rpb25zJyBuYW1lczoNCj4gDQo+IHMvYmx1ZWZpZWxkX2Vk
YWNfLy8NCj4gDQoNClRoZSB2MyBvZiB0aGlzIHBhdGNoIHJlbmFtZWQgc3RhdGljIGZ1bmN0aW9u
cyAiYmx1ZWZpZWxkX2VkYWNfc2VjdXJlX1tyZWFkbHx3cml0ZWxdIg0KdG8gInNlY3VyZV9bcmVh
ZGx8d3JpdGVsXSIuIE5vdGU6IHRoZSBzdGF0aWMgZnVuY3Rpb25zICJibHVlZmllbGRfZWRhY19b
cmVhZGx8d3JpdGVsXSIgDQphcmUgbm90IHJlbmFtZWQgdG8gInJlYWRsfHdyaXRlbCIgYmVjYXVz
ZSB0aGF0IHdvdWxkIGNvbmZsaWN0IHdpdGggSU8gcHJpbWl0aXZlcyBpbiBrZXJuZWwuDQoNClRo
ZSB2MyBvZiB0aGlzIHBhdGNoIHdpbGwgYWxzbyBpbmNsdWRlIGZpeGVzIGZvciBhbGwgb3RoZXIg
aXNzdWVzIHlvdSd2ZSByYWlzZWQuDQoNClJlZ2FyZHMsIERhdmUNCg==

