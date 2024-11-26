Return-Path: <linux-edac+bounces-2633-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A609D9D91FF
	for <lists+linux-edac@lfdr.de>; Tue, 26 Nov 2024 07:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D79C16636B
	for <lists+linux-edac@lfdr.de>; Tue, 26 Nov 2024 06:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC519185B5F;
	Tue, 26 Nov 2024 06:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jq/aeQqs"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EDF1A260;
	Tue, 26 Nov 2024 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732604250; cv=fail; b=TrdAS1hSrwYcSOqgjs8FgUwJd+5vsrYztqrP3rL/cfvmtDZqPQmWbIIVgHH5MoktWVJe9ngfFkICPlMbeG5Oa1UiZPu2LWkfGVx83Zgj1JSYBXHYhoawjOZ4tK2fNNfT4+BSbfBbH214PBjjFmchb0fwK7E4TdfjC/1Qz+H9a3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732604250; c=relaxed/simple;
	bh=7Nkczm3xHLD4/Ytoxyuw2F7eoQI6OFaBIvwbxmIzUrA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MKvIKcnQWkhfQ7rZDiimfDdHA4un3W4n8mkXzS7yukG6t2iu3Xo64yxp5g4JzN+iq2jD1d20g1sLs6PWDAPhguPenx/i8lvJjTzs/n1AA5qns+y9mJOHe7EXXAERmTechGA8XW81YF6YZO597RkbCt/dKBh4W+AySjOMsBeLAeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jq/aeQqs; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFsPM8fgttdvJi1gBfhh/Wu5bdGLO1pbPnDBuu9vMI4p30ZCZ9PNh+taUm5WbhejZQ7MM0TYTnEauKIxWcOC0AGLjdOmeW6s4IylZhp0u1+AVTOrTi4aZigOLAt0q8ZHGe+wK5UGawH+D8ulIt77J5vP4L3LLhMEkZ6Jz+gc9qJQVUMFaQaFtd2Ij1zVSvm0Aa3V5EC4pfZNxeXhbDrochiRSak2RSK72DpeKwIDH0yNyaDUGBRoZv9tXkibldPr03fpr8w96T650VU1DAIUdtweFl63+R8t1P7JKNL+6r2E5AkRyHiUEleZgYmtZQUsZ0gmxXcWODcErfG0cqsmaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Nkczm3xHLD4/Ytoxyuw2F7eoQI6OFaBIvwbxmIzUrA=;
 b=Sw3PDI7DXJ93Cd6HGZvFCgzwwLTOUVdAt6v0s+SMadb36mkJ/ojl3Gc6ZFrgdr8xxgmaig4cAeBNdCWfoPVYIfD7H4nImOOYfpW7IGILJenaggOWSiWde8P6t0HCxkJW8g0OYGSmmveNWlR0cNcsAWMS5mwODDd0XKGoZYaHLZbPw7SRx6x06S42yhUuCCStt2TkXr9r0Qb02aCj+sIJ76RSg6ZYcSVWiKbTZILgU9C/U0N4Kt7EP7BLE0ajmFt5yLtMRM0DsQMO9fuBtR5b0xzVvsOBNyy09yAuDQpf/20MPJRTGNR2AcT8crjZxup6RVgdkPwoYUm6wXQR3GRIGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Nkczm3xHLD4/Ytoxyuw2F7eoQI6OFaBIvwbxmIzUrA=;
 b=Jq/aeQqsp+mSjUX7/POYFL9L6PKynybrACYNFOON5OZ4ezeLzs7gI7oX2GJO1vyLXkdWpWMZ2t1DYFvjbWrFPAUlcvW2qD4+Ubi7HaMQaBURiCMid62sRyMb76oUbFZ7nPnEwf4JOnsl4/7iBSLP2h1vkGPuKtFynCblcLpJNjM=
Received: from SA1PR12MB8947.namprd12.prod.outlook.com (2603:10b6:806:386::7)
 by SJ0PR12MB6832.namprd12.prod.outlook.com (2603:10b6:a03:47e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 06:57:22 +0000
Received: from SA1PR12MB8947.namprd12.prod.outlook.com
 ([fe80::8730:918c:b34b:d058]) by SA1PR12MB8947.namprd12.prod.outlook.com
 ([fe80::8730:918c:b34b:d058%6]) with mapi id 15.20.8158.024; Tue, 26 Nov 2024
 06:57:22 +0000
From: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "git (AMD-Xilinx)"
	<git@amd.com>, "robh@kernel.org" <robh@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "rric@kernel.org"
	<rric@kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: memory-controllers: Add support for
 Versal NET EDAC
Thread-Topic: [PATCH 1/3] dt-bindings: memory-controllers: Add support for
 Versal NET EDAC
Thread-Index: AQHbPMZFeJ9buWK1xU22YGXXUe4Q3LLFFHUAgAQRCmA=
Date: Tue, 26 Nov 2024 06:57:22 +0000
Message-ID:
 <SA1PR12MB89479EFB910D009F2F3A7641812F2@SA1PR12MB8947.namprd12.prod.outlook.com>
References: <20241122100625.24571-1-shubhrajyoti.datta@amd.com>
 <20241122100625.24571-2-shubhrajyoti.datta@amd.com>
 <uw5yvotdr4u5uau7bqjj2qdmkf5ay2bm7km3zhqunbixzljlw6@wi6cujvdhesk>
In-Reply-To: <uw5yvotdr4u5uau7bqjj2qdmkf5ay2bm7km3zhqunbixzljlw6@wi6cujvdhesk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5644bf35-e3dd-483d-89f8-bd1bbc95b696;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-26T06:50:47Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8947:EE_|SJ0PR12MB6832:EE_
x-ms-office365-filtering-correlation-id: 90cda327-86b3-4354-a7e7-08dd0de793f8
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVRYVTZrVERFLzdTZ25OR2hlQXlPMEk0bFZiaVJJMWNNQlNRbitNMjdjOXRl?=
 =?utf-8?B?T1hPMUluTVBXUVZ1TDc5azl1RzU3aUZRT0hkRlZFQzNrekRlZ08yc2R2bFNM?=
 =?utf-8?B?b1lUeit6WHU2Rkx3ZGdYMm9DUXNsMjk2ZDFQSWdDdFkwbHphbm9BcnMvb2h6?=
 =?utf-8?B?THhLa0doM3dxdS93VkZnQlhoL1RQWXJISFV3bXRlbU9lUGFiWW14emdQeU1H?=
 =?utf-8?B?cDF4b2JFaHo5R1RqRjljSTNWMDJldXFRM1NOaGErNEw4Sis1ellvQmFUVldX?=
 =?utf-8?B?RmNzVXk0QjRlUkdGUlhVTEFvdU9BenlXSzhFWDVBYU85aGxCQUhIdWw0NGxI?=
 =?utf-8?B?NEY1Y3BtSnhpbFhzYUp1aG1GMUNROW9MbXlVcDZLdG1mbmE5Wk9NdCtQanNQ?=
 =?utf-8?B?MXlDdHl0VVE1SmFxS2d6eFJjNzV4dFNLTHQ1Q2JQRys5K1ovL3I3a2J0SXBk?=
 =?utf-8?B?L20xaVdvL2dWVUtCWDJFcnBuTXNLcmdVc3crQ01aY2E1VkgrOXlXeVkvazZJ?=
 =?utf-8?B?b2hDWUlTbGdxSFUvYmRsUEN6QkNJOG9HU054WW5pc0luQmlIamhOQXpWUEF0?=
 =?utf-8?B?RU81eExBSWxFM2NFWmExVm1Jc1lOdk5qUytDZ3U2REZEY0RhYytLVTV3VnJk?=
 =?utf-8?B?OS85TXpmdTFRTEVqNmZMUGJZVXQ1WkJKaWp4N3FHNzFjSGJZZTd3S1VzY3Qv?=
 =?utf-8?B?dzdvMTVHZThWTDFjUEd5NzM5RTQrSW1aK1NrS0NHanVEcXFlTjRNZ0pubTFv?=
 =?utf-8?B?UWtvc3A1L1o3RlRDTGs0VGhiLzhINzlKb1NESFd0ZmxOQVUzNDFvU1I1VS9n?=
 =?utf-8?B?L2Mva3piNWx2bDhKU2NJZjQ0MGk5eGJTa0wzRkYvcllxMVE4M2hFeTlndk1j?=
 =?utf-8?B?M2hPZ2NXRFBJRGh2R0pCKytmdmh6NTlra0RPWi84MHZqazBwdjFzdy9aMkk5?=
 =?utf-8?B?TEozUUhTZGxtYU1CWjFrdUVZU2NCcjFwK1dnWW0rNVY1b1pMSUM3aGZKUFF4?=
 =?utf-8?B?eGN0NG56KzNUL3dVTHB4ekduS2VJbWM0aS9hcFJIRHJZZVdjc1NHTDBsWWF6?=
 =?utf-8?B?RGRWOW4raUwrNWxMa0ViZS9iVlhsamdOUHEwTDBXR3RRanozUHhjRXlKUDRL?=
 =?utf-8?B?VkFsdXJISDhHZU8vVUZrRFNsbFBIbXhDVFJaWnVqaS92MElJUzJxRk9nSlJY?=
 =?utf-8?B?MGdQRlRLM2FrNkx0Y3JEQzFGMDJXVjVEdHorc0lXVmFxV2hEZldRbzU1K1pS?=
 =?utf-8?B?V3lhYWxRUFBOR2t1SDFHaklDMklmVXE5ekg1TS9yRFBWUUxTTG45enlXWE5P?=
 =?utf-8?B?bWtJbVp4blRiMU9vcWhrTy9heGRMSDBMYlJMSXNWZUh0MzhXQmJmSVhBMUFJ?=
 =?utf-8?B?blNwV0Y1K1VaU0NzL1d6NEdMbnc1V3BkSTkxNkEybGRhQnZVREZXY1RQcnc5?=
 =?utf-8?B?ZGZhdUpHOWJRSWcwVnJmeCtKMGxjcWs1cm53bEpDMjIvbThHSkt2V2w3U3VI?=
 =?utf-8?B?Q2pTVXN0VTQvM0RLbTVxK3ZFMG9tTkViS09hNzBZN3pEREZ3UnErdWYwMmpj?=
 =?utf-8?B?dTNEMk5PRThDeVU0aGhEdzdnRXRzK0FLVDV5YitZUHJSMW5ubE5MWTBPN2R3?=
 =?utf-8?B?QkRxRXFDSFpVazJMb3ZFNWx4cnFoWGNKV1hVVGZYcEgrbFJUR2FSOGdlT2pM?=
 =?utf-8?B?NGNUT0l0VzVXMmF3Y2xaRGg2WHBFOHFMbGFXOXB4Q1drc3EzVDlnMUdKYUhM?=
 =?utf-8?B?UEtrOTE3cThkU1FocVZtdlQzRjB0M21nRU9EYVR3NlFhNTBGdjEvOWkxblhU?=
 =?utf-8?Q?TUOe6lzcAEu9N5iEdpV3b6YBdrWRX5iQ92n8M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8947.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YllYVkNhY24yc05LNHFyUzcwUGdzbi8xcmUxZ29icVRtMVhJSzc5cDMyVHY2?=
 =?utf-8?B?QVQ3azFNY1VZenFHMlVZTThRTGRmTjBuZ3M2dDE4c085dlNRazl6K1dQQWlQ?=
 =?utf-8?B?bTlUc1RrNDd5ZFZubnRPS012bGJsL2k5OTFLTUsxNTU4ekZvNytIcjFFK01o?=
 =?utf-8?B?d1QrV3h2MU5KcFR2VWNlU1BhQkcvdHVTZ3o3WU53ME9WanQ5c0JKUHQ0N3hX?=
 =?utf-8?B?aExkamE3K0FQVThPNExhbFJGOVg4NWRROE80NlYydHZEUXAzOS9XaHFjM0I4?=
 =?utf-8?B?a1ozVERmN2pyNHRvMEtURDBrbC94WFpURG8wOWtsTWNmMTk3Sk5vaUIxRUhr?=
 =?utf-8?B?YTlxc0xlZDhKTkwwVk1hY05mZkl4a3IvQzFMSVllckF6bXB4S1EydEgxbGZx?=
 =?utf-8?B?TVBKdloySWl5TlBtRjlrc2I4TTNadTVHVDlTcDROejBxVjJEWWhvNUV6WWFD?=
 =?utf-8?B?OVdoUXRXcEdITTVvemRGd0Zlc2tqekZjdGxHQlBnNnVZa0VOVG9nYmZHTWxW?=
 =?utf-8?B?R1Z3cXliY3lOZ2w1ZWZQREplNjZlQ05VYjFTM0hOVFlOd1RJUy8zR3B5aU5v?=
 =?utf-8?B?VXlsNUVYYWR5NkkwZXFlUmJ5a0pCdE1PRTcraVBJZ1VmMmora1pWV0REc1Bk?=
 =?utf-8?B?MHJVV05LSnF1dVRIeXc3UnVIckpRQXYwTUFadWVPa3pvc2FLWThFMjlCdUVN?=
 =?utf-8?B?TFZ2a0UrdDZyc0NvUXVKd1BhYTZpYjhveGY1UGFzTGVkT3g2cGhkbmszY2dl?=
 =?utf-8?B?bTZKZ00zZ1ZVd1I0RkNNK3pMbnUrdkZnMlVCWlR3UG82WDZ5WDNWUWJJVjh2?=
 =?utf-8?B?S2pxZkFjangzTDl4M2dPQ0R5S1pCVnk5L2RLSkpWb2k0R3c3WmJId3BNRVhE?=
 =?utf-8?B?YzVBL1h2MkZZTmZoeWo5eHhDMHl4OXFoTGl6SjQ0YlFQdEtyVDVwVFdNYTZN?=
 =?utf-8?B?aVd0ODF3c2NCT0ZXbkRobW9UTFRSdzZJbnRndFdhNjl5UWtQSDlwV3ByQ0o3?=
 =?utf-8?B?OHIwL2hWVUJiWXdMOUJlcTJWamtVR2ZFVjBlRXdvYWxwQXlNTVZ3TXdsUmFw?=
 =?utf-8?B?NDFrbGlxQWxGbUx2Z0hKTVkxeWd0dHRZYnBiSS9ybCtlUjdoTVRnK3dKVDd4?=
 =?utf-8?B?UWNjQnEzUFAwa00yTWVETS9hSlJaMXRRaSttQmQ5OElMN1pzdFZuRnFjY3VW?=
 =?utf-8?B?S3lxSGNKOWRyOVVOeTFvM0V0NnJ3LzJScEUyejgxZGtsdURIUG9HVG9IVVVv?=
 =?utf-8?B?MndYWi95YjhsMGgvdGo0S2VmYmprUGJYY2VoY2gwWWpmUDJ3cXlwOGJIenJt?=
 =?utf-8?B?NG5uQXkzZEcrZ3YzcEorWHd4anlJUktiRXdqblg1RVpySkEvWmk4Z0kxR1cx?=
 =?utf-8?B?aEsyRy8vQzBGM05Td3VGRjRMaGM0RXZLdFEzTmpwN3RzTnp2UXZoN09iVzNB?=
 =?utf-8?B?VHJOc3ZrT3hoZDZDV3RFZE0rOHF0MVBPVDd5c2JqcExXSXJHRGp4ci9wZlpn?=
 =?utf-8?B?QVBEZDAvQktlLzR6dERaMFVRditFUUpHRnNBUnh1QmsxWWxicWlzSEFrQWtE?=
 =?utf-8?B?eXN4ZVI3ZDVOOG9rVVhFUUdhY0NJcGUvZExCMGY5aFVuR3VWNnpNa0RIeGVr?=
 =?utf-8?B?enNIakhBTzZ0NG9sYnJ6Sjd1S20wMzExV0NBRkNwdmQyTlJhNGt1SlRMMm5D?=
 =?utf-8?B?Y1hxWHpITUh2R2VtOGVlNlBQUWVpOW5XSS9DcVgvcGZUYVVBV1Vmanl6SjlV?=
 =?utf-8?B?b1FXK2NuelJRd2E1RnZXVjZLTHkrNC9UTTlKYWNPdFg3ejdjMExucU5TU3Ru?=
 =?utf-8?B?UzYwYjZpWUh3alMxaXNIZDY1YzA4ZVVCVEhaU0JCbjVXNEM0MitJTE5wRXcx?=
 =?utf-8?B?Mi81N0hZMWZIa1o0UE5LZlAwUjBMM2QvM0ZnazBGZlF0YUF4N2JldWRhSFQ2?=
 =?utf-8?B?ZjhLaTE0UndRRnpsMWV4bUE1NWQwKzQxelh2L2xKaDRNbjRqYnpFVEVoVG9G?=
 =?utf-8?B?bTRNaVlhUkJiWkV2b3F0TTFPZ1lOb2NTMmJnOEVRWHJYQ2FkUHByanBKaWg2?=
 =?utf-8?B?NmwvbW85U2x4b0N1TEt5b0ZpVUtPN3JCakRYRVQxLzlmb25xSUpUMDY5TzlQ?=
 =?utf-8?Q?tzb8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cda327-86b3-4354-a7e7-08dd0de793f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 06:57:22.7104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4aDIoLaf5kVShLDS+yTS5a7fHG88KZ/qspQmXW2f3TAb9yvaMi6Hq/zO0PZPbSIcja+rhwj4hYRn/kj4f15T5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6832

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93
c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFNhdHVyZGF5LCBOb3ZlbWJlciAyMywgMjAy
NCAxMDoxNSBQTQ0KPiBUbzogRGF0dGEsIFNodWJocmFqeW90aSA8c2h1YmhyYWp5b3RpLmRhdHRh
QGFtZC5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGVkYWNAdmdlci5rZXJuZWwub3JnOyBnaXQgKEFN
RC1YaWxpbngpIDxnaXRAYW1kLmNvbT47IGtyemtAa2VybmVsLm9yOw0KPiByb2JoQGtlcm5lbC5v
cmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGJwQGFsaWVuOC5kZTsgdG9ueS5sdWNrQGludGVsLmNv
bTsNCj4gamFtZXMubW9yc2VAYXJtLmNvbTsgbWNoZWhhYkBrZXJuZWwub3JnOyBycmljQGtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIGR0LWJpbmRpbmdzOiBtZW1vcnktY29u
dHJvbGxlcnM6IEFkZCBzdXBwb3J0IGZvciBWZXJzYWwNCj4gTkVUIEVEQUMNCj4NCj4gQ2F1dGlv
bjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBw
cm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtz
LCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBGcmksIE5vdiAyMiwgMjAyNCBhdCAwMzozNjoy
M1BNICswNTMwLCBTaHViaHJhanlvdGkgRGF0dGEgd3JvdGU6DQo+ID4gQWRkIGRldmljZSB0cmVl
IGJpbmRpbmdzIGZvciBBTUQgVmVyc2FsIE5FVCBFREFDIGZvciBERFIgY29udHJvbGxlci4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNodWJocmFqeW90aSBEYXR0YSA8c2h1YmhyYWp5b3RpLmRh
dHRhQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4NCj4NCj4gVXNlIHRvb2xzIHRvIGNyZWF0ZSBjYy1s
aXN0LCBsaWtlIGI0IG9yOg0KPiBodHRwczovL2dpdGh1Yi5jb20va3J6ay90b29scy9ibG9iL21h
c3Rlci9saW51eC8uYmFzaF9hbGlhc2VzX2xpbnV4I0w5Mg0KPiBzbyB5b3Ugd29uJ3QgbWFrZSBh
IHR5cG8gaW4gbXkgZW1haWwuDQo+DQo+ID4gIC4uLi9hbWQsdmVyc2FsbmV0LWVkYWMueWFtbCAg
ICAgICAgICAgICAgICAgICB8IDU2ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDU2IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVycy9hbWQsdmVy
c2FsbmV0LWVkYQ0KPiA+IGMueWFtbA0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVycy9hbWQsdmVyc2Fs
bmV0LWUNCj4gPiBkYWMueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21lbW9yeS1jb250cm9sbGVycy9hbWQsdmVyc2FsbmV0LWUNCj4gPiBkYWMueWFtbA0KPiA+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi4yMmE0NjY5YzQ2
YjYNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVycy9hbWQsdmVyc2Fsbg0KPiA+ICsrKyBldC1lZGFj
LnlhbWwNCj4gPiBAQCAtMCwwICsxLDU2IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IChHUEwtMi4wIE9SIEJTRC0yLUNsYXVzZSkgJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICsk
aWQ6DQo+ID4gK2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21lbW9yeS1jb250cm9sbGVy
cy9hbWQsdmVyc2FsbmV0LWVkYWMueQ0KPiA+ICthbWwjDQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9k
ZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6
IEFNRCBWZXJzYWwgTkVUIEVEQUMNCj4NCj4gcy9FREFDL01lbW9yeSBDb250cm9sbGVyDQo+IG9y
IHNvbWV0aGluZyBzaW1pbGFyLCBJIGd1ZXNzLg0KDQpXaWxsIGRvDQoNCj4NCj4gPiArDQo+ID4g
K21haW50YWluZXJzOg0KPiA+ICsgIC0gU2h1YmhyYWp5b3RpIERhdHRhIDxzaHViaHJhanlvdGku
ZGF0dGFAYW1kLmNvbT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOg0KPiA+ICsgIFRoZSBpbnRl
Z3JhdGVkIEREUiBNZW1vcnkgQ29udHJvbGxlcnMgKEREUk1Dcykgc3VwcG9ydCBib3RoIEREUjQN
Cj4gPiArYW5kIExQRERSNC8NCj4gPiArICA0WCBtZW1vcnkgaW50ZXJmYWNlcy4gVmVyc2FsIE5F
VCBERFIgbWVtb3J5IGNvbnRyb2xsZXIgaGFzIGFuDQo+ID4gK29wdGlvbmFsIEVDQyBzdXBwb3J0
DQo+ID4gKyAgd2hpY2ggY29ycmVjdCBzaW5nbGUgYml0IEVDQyBlcnJvcnMgYW5kIGRldGVjdCBk
b3VibGUgYml0IEVDQyBlcnJvcnMuDQo+ID4gKyAgSXQgYWxzbyBoYXMgc3VwcG9ydCBmb3IgcmVw
b3J0aW5nIG90aGVyIGVycm9ycyBsaWtlIE1NQ00NCj4gPiArKE1peGVkLU1vZGUgQ2xvY2sNCj4g
PiArICBNYW5hZ2VyKSBlcnJvcnMgYW5kIEdlbmVyYWwgc29mdHdhcmUgZXJyb3JzLg0KPiA+ICsN
Cj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgY29uc3Q6IGFt
ZCx2ZXJzYWxuZXQtZWRhYw0KPg0KPiBXaHkgdXNpbmcgZGlmZmVyZW50IG5hbWUgdGhhbiBhbGwg
b3RoZXJzPyBLZWVwIGNvbnNpc3RlbnQgc3R1ZmYgZm9yIHlvdXIgU29Dcy4NCj4NCj4gQWxzbywg
cy9lZGFjL21lbW9yeS1jb250cm9sbGVyLywgZGVwZW5kaW5nIHdoYXQgdGhpcyBzdHVmZiByZWFs
bHkgaXMuDQoNCldpbGwgZG8NCj4NCj4gPiArDQo+ID4gKyAgYW1kLGR3aWR0aDoNCj4gPiArICAg
IGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBERFIgbWVtb3J5IGNvbnRyb2xsZXIgZGV2aWNlIHdp
ZHRoLg0KPg0KPiBVc2UgZXhpc3RpbmcgcHJvcGVydGllcy4NCj4NCj4NCj4gPiArICAgIGVudW06
IFsxNiwgMzJdDQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9u
cy91aW50MzINCj4gPiArDQo+ID4gKyAgYW1kLG51bS1jaGFuczoNCj4gPiArICAgIGRlc2NyaXB0
aW9uOg0KPiA+ICsgICAgICBOdW1iZXIgb2YgY2hhbm5lbHMuDQo+DQo+IFVzZSBleGlzdGluZyBw
cm9wZXJ0aWVzLCBlLmcuIHNvbWUgb2YgdGhlIEREUiBzY2hlbWFzIGRlc2NyaWJpbmcgbWVtb3J5
Lg0KPiBMb29rIGhvdyBvdGhlciBiaW5kaW5ncyBkZXNjcmliZSBhY3R1YWwgY2hpcHMuDQo+DQo+
ID4gKyAgICBlbnVtOiBbMSwgMl0NCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwj
L2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsNCj4gPiArICBhbWQsbnVtLXJhbms6DQo+ID4gKyAg
ICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgTnVtYmVyIG9mIHJhbmsuDQo+ID4gKyAgICBlbnVt
OiBbMSwgMiwgNF0NCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRp
b25zL3VpbnQzMg0KPiA+ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+
DQo+IEVoLCBubyByZXNvdXJjZXM/IEhvdyBkbyB5b3UgdGFsayB3aXRoIHRoZSBoYXJkd2FyZT8g
VGhpcyBsb29rcyB3YXkgdG9vIExpbnV4eS4uLg0KDQpUaGUgYWRkcmVzcyBzcGFjZSBpcyBzZWN1
cmUsIG1ha2luZyBpdCBpbmFjY2Vzc2libGUgdG8gTGludXguIEluIHRoaXMgc2V0dXAsIHRoZSBz
ZWN1cmUgZmlybXdhcmUgKE5NQykNCiBjb21tdW5pY2F0ZXMgdGhlIG5lY2Vzc2FyeSBpbmZvcm1h
dGlvbiB0byBMaW51eCB0aHJvdWdoIFJQTXNnLg0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlz
enRvZg0KDQo=

