Return-Path: <linux-edac+bounces-5271-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3088DC243CB
	for <lists+linux-edac@lfdr.de>; Fri, 31 Oct 2025 10:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59BA3BAC17
	for <lists+linux-edac@lfdr.de>; Fri, 31 Oct 2025 09:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CDA3321B3;
	Fri, 31 Oct 2025 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DTEv0lnC"
X-Original-To: linux-edac@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013066.outbound.protection.outlook.com [40.107.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D75432ED26;
	Fri, 31 Oct 2025 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903728; cv=fail; b=U97smFI2KQDff/ICOBBsjMKg6WHNJXEcZ5WnvZu1+JRotIPpreTVH1N68slUT0xx+Ujkpxf1PlxW9S1ysG4zAJMgksm80xwG8NRCMHE0ngB4BuM7km1/kR/BOIm8lY5R6Hn/MslE51JoXbTLUL4YANTNcWnXE/wjLeeHkQ+5JJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903728; c=relaxed/simple;
	bh=29E2KnCKvg/Wu12aBfMUofvwEQxm6rTKfLzIOUwjob0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g+Lb/kmGxrgmqH8ZT1QSGWrcuW+B+EV8XBWYUeFLoXBmyfxf3k3k8dJ8SMtkXqCcF1guFYAah1WvN1hxUhaI1XiSXEgXZS7osoLCu/sJCkhTwA6cHvnjMBHZSKf6TaCX0Uvae80VzQSXFxrjlfntc/L8gtqqr/1En7ctwO5prcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DTEv0lnC; arc=fail smtp.client-ip=40.107.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8rD+ikk9gTp/QEEhgNzHHwX4fSxYnV6DoGCFjVxZWv6oAA5cBCMn5ciSg+9ThVxN3TmzQkCjEznsoRqnZbtTzqsKvrxV/2W0MCgTDNsAnGxhIdE68fkbT+IJuXldkUp4wkjoqvw7y93AVeiXvuoyDQprgBGApZwpBQ4Fr7k0yKGrpUNDbp0itIAyps5NOj5vq6eH2iwKS97vitPhzXw6M4b71MrfeTS62fs72Pu0tIDdidB/fGaMZTmDzSiGAPsqccGJpZfl7xreSQw9OPjTR7eQ+/mEJSdHqfI52gx2Qcfab5W64AgFECctOeTwOnSDtIqeaDX8NuMZXynjAPs0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29E2KnCKvg/Wu12aBfMUofvwEQxm6rTKfLzIOUwjob0=;
 b=WAQKgwV5TSboB191kckihDaUx9R05eqlWIUeLNioR1tWRKBhBPMMhEVg9RmrSUg0HA5BKKN7OZjtJQrpi6+6a4qhRSMfFEXFB+wLeYOcXzC7xhSIQvDnmj8hjmv95qREnQLN9zJfF3eHMjLgkEq+zI1Ov02XijvhguGKCNP21ir3AVdQ+6KvCO5CqLzKMKpr4uqRS4A+2JIv6/osYmfMlnGQQM/Ov7hL5PNiFWkHuRuhLIjzasRfNpZfHpaqMY+573ksGol6qXTTmddrguSLOFAjdEZs6ziEMM0NQWX72Yqmuge9GOFUYn4VeICqAq2mHgdNUmpOgL2lOjtsamEe4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29E2KnCKvg/Wu12aBfMUofvwEQxm6rTKfLzIOUwjob0=;
 b=DTEv0lnCSS62yHcaYUCqsoSV2TAGtsbPTMBOgvVDD8OxgFG6TD2na/dd5XFGREGd5yl3nY/ovcVn4ruhT10cVPsFv22GS3TSVku7BLng4Ifjf34Frbn7zKCeEsYQnRK5siHrSdJDd2KJgQG+b381i0LqPt0D9f56sukSFVKkhw0=
Received: from LV5PR12MB9828.namprd12.prod.outlook.com (2603:10b6:408:304::19)
 by CY5PR12MB6105.namprd12.prod.outlook.com (2603:10b6:930:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 09:41:58 +0000
Received: from LV5PR12MB9828.namprd12.prod.outlook.com
 ([fe80::18a1:d79c:8c9:dbda]) by LV5PR12MB9828.namprd12.prod.outlook.com
 ([fe80::18a1:d79c:8c9:dbda%3]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 09:41:58 +0000
From: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "git (AMD-Xilinx)"
	<git@amd.com>, "shubhrajyoti.datta@gmail.com" <shubhrajyoti.datta@gmail.com>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Robert Richter <rric@kernel.org>
Subject: RE: [PATCH] EDAC/versalnet: Handle split messages for non-standard
 errors
Thread-Topic: [PATCH] EDAC/versalnet: Handle split messages for non-standard
 errors
Thread-Index: AQHcRBCX/Q53Gq1QhkS0aPs/5A/O4LTZIh8AgALqIvA=
Date: Fri, 31 Oct 2025 09:41:58 +0000
Message-ID:
 <LV5PR12MB9828A123A3ADFA1EB177E58681F8A@LV5PR12MB9828.namprd12.prod.outlook.com>
References: <20251023113108.3467132-1-shubhrajyoti.datta@amd.com>
 <20251029130832.GBaQIR0CF8kSl6exi7@fat_crate.local>
In-Reply-To: <20251029130832.GBaQIR0CF8kSl6exi7@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-31T09:39:02.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV5PR12MB9828:EE_|CY5PR12MB6105:EE_
x-ms-office365-filtering-correlation-id: d835ab91-db2f-40e5-e608-08de1861bc4d
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?T0tUMFdvT2hDOU5rRUMwWjU3UlgzQVdqMlNrNHJnd2ZLN0hDNDVBMnljU0lO?=
 =?utf-8?B?ZWhrSlQ3QnA3ZldzcWFsMEtxQVAvRTRVVnpaNVhZS1YrSzJNN0RFWG0wclJY?=
 =?utf-8?B?SjNOQW95Zkl3aTQwY0J2dnExTkJaVFVtZEN0ZkppdXB3UEVtY0IyblJjSk0r?=
 =?utf-8?B?NGNiRGd4a3kvaXMyQlZEakNmd2p3bmU4dDF6VW55eGVDOTloK3I0ODBlTlNr?=
 =?utf-8?B?dzRrM21zajZYSU5aRXc4RFpjaE5iNkFGS2RybisxM1VjQ2NMclVvbWFObkdZ?=
 =?utf-8?B?czBJMVljbnlyMEhMWHhyclYwTjFjM2p5Z05OZXlubFpNSC9RcU5kZFBpcVI1?=
 =?utf-8?B?S2xMYzNRNENSa2x6cGYxSno4b25GaElRTDRUdVpwL0M2YkhsakNzVDQ5cW1M?=
 =?utf-8?B?akhlNFlvdWRXSUJnU0xBRVBucmN5NUdyN3M5eHlERGcya0FHMmltVXdkcnpL?=
 =?utf-8?B?cDFzbHcyMFhQU0MvbEcwWEhmUXRERVBHUUFXbUpxa2VmamlFSUZSTkNSZDJS?=
 =?utf-8?B?SnkxWWZ2dVpnM2xRNUVtT1c5Y2xLcElocDlFQmdVdmhGSUdaRTYrbzc2ZHpk?=
 =?utf-8?B?dVcyTmhnVkY5ckcvZWIzRHRJNTM3Mk5qV2E1RmpOeWpTSU9RMmdobUlBYXp0?=
 =?utf-8?B?eDUyRUl1T3RTMVdoTTdJMFdDRkJtZWwxMVJmU3o0bnRBRVdQRmlKeGhiZmRz?=
 =?utf-8?B?K0NWaEJnU0FKQW5nK1ZnUGRieVduR2R6ODVpbHQzVXFKK3hDODdFNnJQbEhn?=
 =?utf-8?B?Q1k5WXlacHdSUlNFU0lDV2pjRkxnR0RkZXF3VUtJeXgxa09WRnlKdEJ6dGFX?=
 =?utf-8?B?RXBuamg1Mk5ReW80VzZLSEN1ZURmRTZUdExzZVZaUW9DVlBqVUM3SjYwRisy?=
 =?utf-8?B?aHIyUnZocXEyeGR3cjhFOUxHb1puZFV3K254aldwVmtnQ0VRQjlYdzZRWm1S?=
 =?utf-8?B?SXVoWlovcE01T2xJY0UxZVhHR3pVTkFiQVloeXNFYi9nS2dlaE1CWEtNWHRx?=
 =?utf-8?B?azJOSXRjeTVjY2RXWmpwd2xhcDRuUllLa2xIRlIxcUpPamh6MnBnaUp0S3JT?=
 =?utf-8?B?YXM0TXgwdTJGaVIvbUZMakZ2VytUTmVCdGlzNWo4MGlxVVY0Tm5YdE5wNWY3?=
 =?utf-8?B?SDgwY3I2UmhsL2x4RWZUTjI4YVNtMmdwY1p6WHVyaXpwWHlXVG5ibk94MDFJ?=
 =?utf-8?B?YUZ4VWlIVkJkckx3WGVKTG1uRjRmNE5UaW1hVm5VbmJFL3lBdEJZZDNHNHlr?=
 =?utf-8?B?UjVJV3dieE5rR0tmbDFROVFPOG5ieGJxbWxVK3duUUpPZnBzM09Yd2dSYXpy?=
 =?utf-8?B?Z3hYNDBERXR1eWhYcTVLcFVTc2ZneTc5K1Jpa01yaXovN0tEZE5vdGppaGti?=
 =?utf-8?B?a3pVdFJ4THQ4ZWZGK09tRFhtZWFaaUdKRUFMMFBRUDI0V21wMlcybU1maTZn?=
 =?utf-8?B?Rm0vbXJqMW11ZTFZVzV5MHAzWEE5MnRKOVVQM2ppTzFIMWl0SEJaUHVCWVc2?=
 =?utf-8?B?bC83MDVlUUxaVVZMMnloS3hYWkwzMmNzTmpCTDJCY1piY1JBYnFEeFZ3QlVF?=
 =?utf-8?B?OTh4V1ZPTlVUMCtQZWVlZFkyR2FBTGxOVWtOVU14VUg1SXlTbm5EM3M4Rk9Y?=
 =?utf-8?B?bVM2MzNuUmRvQlpzODFKVHV0VmFuNStZSVBac2xGYkQ0dEhod09XSlFFOFFt?=
 =?utf-8?B?V0g1dk1yVWlmdlByeGdYV2tKZXMvUzVYdnowMmZtVWNLdHU5cTZ6ZzI1TzNs?=
 =?utf-8?B?NXB5V2ZwN2dGcEJQOE5yZ0xUYnhjVnNGcG9VcTNqV3RTWkgyUUJhWnJ2Nk1s?=
 =?utf-8?B?d0QzcTJ2WGRValJHcWNqdytuQnVqa2wyYkhZRStiS1VUM28ydjRjVER6RFk2?=
 =?utf-8?B?MEFqZUVGNFpxSFZPSWY4VGN5UGZMM1VHcXZIL3lqcGpjY3F2NU5BV2dWOHoy?=
 =?utf-8?B?SDh4MDRCRjdja29YQlBHRVkwZWlzVzhEamViZlB5a3dCbXlMbjFaRk5QUzkr?=
 =?utf-8?B?NldhZUNHSXcwNk9acVRsc2pjQ0IrZ1VwSHlzK2hiaW1lMFRJYU9vTVZTblJ5?=
 =?utf-8?Q?uAbs9g?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9828.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OHNOd09pSUQ1Qm80RlU5bzhYL0J6bWtWMCtCUXVMdFZWRVpEMERsZnJHTkhp?=
 =?utf-8?B?d1NUUlNlK1c3WnNLV1BaMk85ZSthNytaNWlLbG9HMk8xYkhtK3JFSCs1bkRp?=
 =?utf-8?B?bmtGVkFJalFqRDUxaWVCR1lZNGpYSkFJUmJjS3JzNVVrOVNWbjZHd21hMEt1?=
 =?utf-8?B?R0NyN1o4WVJRZ1MzRXZhNXl6MXNOVWdDOUVZc3ZwbEk1VTVZZ3phOHBVTFlk?=
 =?utf-8?B?MFRRVVF4bkhEc2lIZGR3aWlDaGtDNEVmSG5DQitUaHlpSDlMSHZRa2xDWjhS?=
 =?utf-8?B?TjVzQTh1SlJ4ZE8vcFJhajhKRkVJQjArWTBMYWhZQ3laeVczcERmTmdLVkpG?=
 =?utf-8?B?ZE1xa2tydHJWSThBK21zRkdjUjZtVVJDYSt0N0F5S0Vkc01KZDRVa3JScytY?=
 =?utf-8?B?U2Z5Um0vYXMxMUQyMkF1YkNyWFlrSmhJa3RHaXR4OFBaSjBxaTN4Wkp6UzI3?=
 =?utf-8?B?NVN3SHQyVjVMcW51V1BNcWVTVlJIZUduODBQamVoMzREeUdwMWVJemxLZERh?=
 =?utf-8?B?QUtuYlJ5em5oM1ZZYXh1QnJLekV0a2ExcUZIa080Z2lWbHByaGl6K2V6SG5V?=
 =?utf-8?B?RFB4eStPcGd4R3RQam54UHd2aDdDWG8raFpkM3lYZlE2enFCTmxjTUgycGRB?=
 =?utf-8?B?YUVvcEhVbkJlY1gyOElCM2xraFpQYzVodmJSSjIybFlsVlcva2FJMlpDRE12?=
 =?utf-8?B?Vk5paHRJNUpmT3gxSzJLNmR0K2plM0ZqdFNleHUwb3JLVVBZLzB5T3J6L3ZM?=
 =?utf-8?B?d0YxYThjWkEzdVR0T0VGQlRmWEY2YmV1dFhobjdDUkl1WEN3YTlVY0pPSnN3?=
 =?utf-8?B?Vk1YeTg3Vzd2WDF0V3dtUHU3VXRuNnkyd0ZCN05CWC9lWjFCRGd4WC8rZkRE?=
 =?utf-8?B?cmtnZUlmVVdWOGJlVmRTOXpFK3h6OSszVy9WQlJUcEJJbGxGRWlCYXJ1WTdj?=
 =?utf-8?B?OExxeXVReVJIa05sbC9odXdaN1VZdVF6MXFvU0JZT2JTQTA3T0NyS1pGWXdV?=
 =?utf-8?B?NmV2MWs5RjUrMjZsM2RJd0ZvanNPeFgwUW9peGVuSVRKd2NFNDhPOXcvS25H?=
 =?utf-8?B?dUQ1bVd4T083QURNN2RUSnhNZXFWaUU3MjllZ3NjaHRZYllXV0ltYzU5TXRO?=
 =?utf-8?B?UDFYSWxEazNNQUF1NFZjWjlmeGt1WmMxYUM3UkFmVXh3cGs2OVRUaHJtbmd5?=
 =?utf-8?B?NWMrUXhvZTRWNTRJUTYrTGxBRG0vODIyaU9yMmRJeCtJaGFNc0dkREQzM1Vi?=
 =?utf-8?B?bXk1aVJOVjRhd1J0UWlxYmFGZm9vdUZQVlVPVFVnYllISE5kbUNkZGNxT2x1?=
 =?utf-8?B?Z0hPY0FqZEZhNDJ0MlA0V09Ba0MrQjFGYmZMOXlWS1hTWFliSHVrd1JhbzZr?=
 =?utf-8?B?YzJyM2tPLzhFYzFzdGpSUWI4bkhWOWgrRHpORVV1M2h4bFMwbk5CUkNoa1NQ?=
 =?utf-8?B?TlNDZVVkRWN5d2xqa0hWS0VrSmQzTVh5REErTUhORmduandkSm5XcGtBcUhp?=
 =?utf-8?B?Yk00T1FnVWEwWDRnNHZmRkZvSmtnN3JIRjVoOUxHb1J5TFE2RTNOcktKbjlq?=
 =?utf-8?B?R2IveThYRnFWZ2dMejhZa1NnK0Nma1FXTU9XQnNxSWZGWkZWVm0wQW03TU5E?=
 =?utf-8?B?V1dQbndEVVlzNkE5WnF2MHp6OU9JZzhUMUdEMndJUEMzcFR5RytTKzgxRkJH?=
 =?utf-8?B?aUc4M0FGaU9MNE1LdURjeklRK0ZZVGpUTlRMUVZic0dLbllIT25jVGdONEx3?=
 =?utf-8?B?Ym9PZHcwTm5uWmkwb2lPa0RpL2dRWTNHSGVFT01QODdDbUluYUhySTVPeUM4?=
 =?utf-8?B?V0ZMNXVIQ3BXZWczS0dyWkVaOFJVVEJSNGRZY3hTT1hIZjZ6VTRnQXlTa0dK?=
 =?utf-8?B?b3BQTXpia253cTNDSzhuVnRNNXZFL0NRMWxKUG5RZnNvNytyYkRLOG1oZEVK?=
 =?utf-8?B?OE5tRk94bHJXcEJIM2hjNWtlMDRjd2hNZlVlSHpVZzB4TDZmcjM0aXJGcEFN?=
 =?utf-8?B?WW45Y3VHNVY5WGxYZmk2SFdlMXptNFRLOEluVGNzRHF5bThYc25BQlJsenhv?=
 =?utf-8?B?eEpxNnVlS2tFdEF0YlVmRGNqbkFNaSswbzBEeFN1TWZWTEQyOHVWb045MFV4?=
 =?utf-8?Q?fhX8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9828.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d835ab91-db2f-40e5-e608-08de1861bc4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 09:41:58.2692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rdod86n8jsHifZedlB6SXlQ9CXh13PHtBEhcSuf4a7BGmWh//ttGriYLvLVuZUj8X7gLTrfUclH6GTY3ZgwMng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6105

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDI5LCAyMDI1IDY6Mzkg
UE0NCj4gVG86IERhdHRhLCBTaHViaHJhanlvdGkgPHNodWJocmFqeW90aS5kYXR0YUBhbWQuY29t
Pg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtZWRhY0B2Z2VyLmtl
cm5lbC5vcmc7IGdpdCAoQU1ELVhpbGlueCkNCj4gPGdpdEBhbWQuY29tPjsgc2h1YmhyYWp5b3Rp
LmRhdHRhQGdtYWlsLmNvbTsgVG9ueSBMdWNrDQo+IDx0b255Lmx1Y2tAaW50ZWwuY29tPjsgSmFt
ZXMgTW9yc2UgPGphbWVzLm1vcnNlQGFybS5jb20+OyBNYXVybw0KPiBDYXJ2YWxobyBDaGVoYWIg
PG1jaGVoYWJAa2VybmVsLm9yZz47IFJvYmVydCBSaWNodGVyIDxycmljQGtlcm5lbC5vcmc+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIEVEQUMvdmVyc2FsbmV0OiBIYW5kbGUgc3BsaXQgbWVzc2Fn
ZXMgZm9yIG5vbi1zdGFuZGFyZA0KPiBlcnJvcnMNCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdl
IG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0K
PiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5n
Lg0KPg0KPg0KPiBPbiBUaHUsIE9jdCAyMywgMjAyNSBhdCAwNTowMTowOFBNICswNTMwLCBTaHVi
aHJhanlvdGkgRGF0dGEgd3JvdGU6DQo+ID4gVGhlIGN1cnJlbnQgY29kZSBhc3N1bWVzIHRoYXQg
b25seSBERFIgZXJyb3JzIGhhdmUgc3BsaXQgbWVzc2FnZXMuDQo+ID4gRW5zdXJlcyBwcm9wZXIg
bG9nZ2luZyBvZiBub24tc3RhbmRhcmQgZXZlbnQgZXJyb3JzIHRoYXQgbWF5IGJlIHNwbGl0DQo+
ID4gYWNyb3NzIG11bHRpcGxlIG1lc3NhZ2VzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2h1
YmhyYWp5b3RpIERhdHRhIDxzaHViaHJhanlvdGkuZGF0dGFAYW1kLmNvbT4NCj4gPiAtLS0NCj4g
Pg0KPiA+ICBkcml2ZXJzL2VkYWMvdmVyc2FsbmV0X2VkYWMuYyB8IDEzICsrKysrKystLS0tLS0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2VkYWMvdmVyc2FsbmV0X2VkYWMuYw0KPiA+IGIv
ZHJpdmVycy9lZGFjL3ZlcnNhbG5ldF9lZGFjLmMgaW5kZXggZmM3ZTRjNDNiMzg3Li5hMDU1ZjU0
YTM4OWINCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2VkYWMvdmVyc2FsbmV0X2VkYWMu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvZWRhYy92ZXJzYWxuZXRfZWRhYy5jDQo+ID4gQEAgLTYwNSw2
ICs2MDUsMTIgQEAgc3RhdGljIGludCBycG1zZ19jYihzdHJ1Y3QgcnBtc2dfZGV2aWNlICpycGRl
diwNCj4gdm9pZCAqZGF0YSwNCj4gPiAgICAgICBsZW5ndGggPSByZXN1bHRbTVNHX0VSUl9MRU5H
VEhdOw0KPiA+ICAgICAgIG9mZnNldCA9IHJlc3VsdFtNU0dfRVJSX09GRlNFVF07DQo+ID4NCj4g
PiArICAgICBmb3IgKGkgPSAwIDsgaSA8IGxlbmd0aDsgaSsrKSB7DQo+ID4gKyAgICAgICAgICAg
ICBrID0gb2Zmc2V0ICsgaTsNCj4gPiArICAgICAgICAgICAgIGogPSBFUlJPUl9EQVRBICsgaTsN
Cj4gPiArICAgICAgICAgICAgIG1jX3ByaXYtPnJlZ3Nba10gPSByZXN1bHRbal07DQo+ID4gKyAg
ICAgfQ0KPiA+ICsNCj4gPiAgICAgICBpZiAocmVzdWx0W1RPVEFMX0VSUl9MRU5HVEhdID4gbGVu
Z3RoKSB7DQo+ID4gICAgICAgICAgICAgICBpZiAoIW1jX3ByaXYtPnBhcnRfbGVuKQ0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICBtY19wcml2LT5wYXJ0X2xlbiA9IGxlbmd0aDsgQEAgLTYxNSwx
MSArNjIxLDYgQEANCj4gPiBzdGF0aWMgaW50IHJwbXNnX2NiKHN0cnVjdCBycG1zZ19kZXZpY2Ug
KnJwZGV2LCB2b2lkICpkYXRhLA0KPiA+ICAgICAgICAgICAgICAgICogbWVzc2FnZXMgdGhlIG9m
ZnNldCBpbmRpY2F0ZXMgdGhlIG9mZnNldCBmcm9tIHdoaWNoIHRoZSBkYXRhIGlzIHRvDQo+ID4g
ICAgICAgICAgICAgICAgKiBiZSB0YWtlbg0KPiA+ICAgICAgICAgICAgICAgICovDQo+DQo+IEkn
bSBndWVzc2luZyB5b3Ugd2FudCB0byBtb3ZlIHRoYXQgY29tbWVudCB0b28/DQo+DQo+IElmIHNv
LCBJIGNhbiBtb3ZlIGl0IC0geW91IGRvbid0IGhhdmUgdG8gcmVzZW5kLg0KDQpUaGFua3MgZm9y
IHRoZSBjYXRjaCAuIEkgYWdyZWUuDQoNCj4NCj4gPiAtICAgICAgICAgICAgIGZvciAoaSA9IDAg
OyBpIDwgbGVuZ3RoOyBpKyspIHsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgayA9IG9mZnNl
dCArIGk7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIGogPSBFUlJPUl9EQVRBICsgaTsNCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgbWNfcHJpdi0+cmVnc1trXSA9IHJlc3VsdFtqXTsNCj4g
PiAtICAgICAgICAgICAgIH1hDQo+DQo+IC0tDQo+IFJlZ2FyZHMvR3J1c3MsDQo+ICAgICBCb3Jp
cy4NCj4NCj4gaHR0cHM6Ly9wZW9wbGUua2VybmVsLm9yZy90Z2x4L25vdGVzLWFib3V0LW5ldGlx
dWV0dGUNCg==

