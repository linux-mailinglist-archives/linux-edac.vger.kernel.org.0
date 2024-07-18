Return-Path: <linux-edac+bounces-1554-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFFF934F6D
	for <lists+linux-edac@lfdr.de>; Thu, 18 Jul 2024 16:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7112813D1
	for <lists+linux-edac@lfdr.de>; Thu, 18 Jul 2024 14:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968A613D62E;
	Thu, 18 Jul 2024 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MXS1Is8y"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3E5143C45;
	Thu, 18 Jul 2024 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721314433; cv=fail; b=Z9PsMCbOMkUvOy9LQzO39wpyxhFT3FYjwyAQdGt7zquZogjX/mrQKHs0ibdXH8yZAnhN7047iIrm/WMEIonzm9FK0CAgfwN9ajj9rnF2C97KWGVW5OoSlfKZ26KcmevJ3a9yhM24veG0BxN0NT6loiwcYf4nLcN6gJWbdiIBD68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721314433; c=relaxed/simple;
	bh=cvHAMMN0p9UlerBEi689hfDDVq9vYaHTMh5HQjzYHh4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K+Tz6g8mi0WSHRKLKsI6a3HjrDfx+GmfI10QJcHOyNIUSKRdzsY71QVcvA6n+ptkFUkgXmmxZRUQGeTQ6bUJyNXw+zuQDOvjm+7UCd4ZtwAQLcgtZDhGPl2B1xPeJLihiGCItPhh5pKuGiEkkxZwdl27aFsskj69CJWk5ahXweQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MXS1Is8y; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnjKBlLcS+2LJlkW5QNZJoQ1oiTONbNZGb9iKyqqlkwbk8rrv2moVNz5N2pJLq63BQH8X8fMLK72jwkYCEt/YBsGJMglJ0tYTOIOXVTC3Wxt2QYfv5F+0V92GPqDO4m4yotG3/hYrMh9Ufyq4o83krlW05e+083GRCqxusquRfGi8rAfnTOQRIORhsSQmrVDhzu/Q6FyX/yvqNBIenLsGcAP51Y7jcKxTpUiniyIVwhNRz2thfEgGGXNYYtbHzkxlHoOiPtVbaJWwEclCrSgVj7T+xrlrAnjC06K4vdAqTuYGCuEL8vfFV+w8GLS9oL722O9LOkP8TF+0abj6CrG0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvHAMMN0p9UlerBEi689hfDDVq9vYaHTMh5HQjzYHh4=;
 b=vcMqZoi5AcaoZeU74MSKugS6iez90Efv8CQPRIyXnT+gNWWE7SXoM7sNAdWugsziUK/mzHwb6jpXwEL6QRzgEccNBdBinBQUZ6qwYWeI29EDyzyQB9UNliaQ5NojuQZcfINOdjiHqJv100nKrheejgqLftI9kSiNGiSEd2G/I5nlgJbMOQ7NlCvmCHGWSWr6SRL+OAHdmexDbMLQEyEN9LaW4/O77UcO2Fa0jKhaDDp0wRMX043VFRTeNTs8iwYObr3ntaLcbwD+ISsweuQeDFXPJmDXpDHpY2BExOuqqR7eWJBbJBWmD0ggLyZZ+HiJIfPHdfZD/sOOKw8I/5LrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvHAMMN0p9UlerBEi689hfDDVq9vYaHTMh5HQjzYHh4=;
 b=MXS1Is8yp+JaVAMG0huZULgs3SWm6njt25X0asKh0HX4bAFDmgsqOnGTaSETjNs7ttvZhQhaTOc8Cvz0tVBv1xEjM7+hPe2yaPaZFP6xkoUXqBIR0RrGo+NOxnZisUpJUqBswt9GvmH9e2Ygglr7YvIwxsSI6cBPWAkmye55kFc=
Received: from BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Thu, 18 Jul
 2024 14:53:48 +0000
Received: from BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::8b79:8f25:656b:2887]) by BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::8b79:8f25:656b:2887%5]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 14:53:48 +0000
From: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To: Ma Ke <make24@iscas.ac.cn>, "Potthuri, Sai Krishna"
	<sai.krishna.potthuri@amd.com>, "bp@alien8.de" <bp@alien8.de>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"rric@kernel.org" <rric@kernel.org>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3] EDAC/versal: Fix possible null pointer dereference in
 emif_get_id()
Thread-Topic: [PATCH v3] EDAC/versal: Fix possible null pointer dereference in
 emif_get_id()
Thread-Index: AQHa2ReEJZUSgp6QqUu7LLpWj9CU5rH8kg9Q
Date: Thu, 18 Jul 2024 14:53:48 +0000
Message-ID:
 <BY5PR12MB49028579F7C1936FD0D8A12D81AC2@BY5PR12MB4902.namprd12.prod.outlook.com>
References: <20240718133618.802667-1-make24@iscas.ac.cn>
In-Reply-To: <20240718133618.802667-1-make24@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5297d454-9960-499f-b13d-0247a6dfd4cd;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-18T14:52:33Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4902:EE_|SA0PR12MB4398:EE_
x-ms-office365-filtering-correlation-id: e19f23f9-b738-43e1-240a-08dca7396e14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/8AsKvJheJ4rrrhc9KsNPIivo79D61xjVIe2g80xskQGMn7HVZX6iSnFPelU?=
 =?us-ascii?Q?ZGkYBGLGm1A/c5v3lyhgVkKKHR7q/PIFkegcU6ddrJxe7lozesOX6CwYbJ9E?=
 =?us-ascii?Q?0wkAzySL3OK7brrO9m4PRl0ZAMNC4KmBpnjYYbsiry5EaOmq/5SdiPacf2nL?=
 =?us-ascii?Q?B840Mx89JZ8HdFCzQdo6UlgFG1UJu8fe+Z37FaRcBdF3f6hAdP8uEH/bYIGu?=
 =?us-ascii?Q?PQsG2Nz1USqapAu9vmhhEd99LFyeDhtQtc/FeHsjA9NSPcdfftZUYZQppLlu?=
 =?us-ascii?Q?50zK/WYIa57v5hw0WdRizpJO9e6nriDhK7vuR5AahkpTyyEAoMcEnDnYXrmP?=
 =?us-ascii?Q?jXY04oX9Vfn4x39RP9QuBCu4Y4gmLD3hal44qckzmt3l4tYTxPQ6G8IDoG5M?=
 =?us-ascii?Q?FV3VQSbsDNFJVSzH53oeH8cDkmwzbK4H8fs8/Je18JHOnxV1PTMXYX7iABvk?=
 =?us-ascii?Q?IGY+NtmegZXM4wFQ+APYU1lbrrnurfZp8jG5oWvvtE8OepCDXM4Ged7MGpOz?=
 =?us-ascii?Q?Yy7r40vHGPw5kH0yHmV52BcyqDxFd072LC5CSVbV8x1qf+IDbkJCPzacLCe6?=
 =?us-ascii?Q?H0urHVEmvp+urjrq9WHPVFNtmhlr5rw9HbQ7oufa5AaUNXn1Kgi/KvRDMMhm?=
 =?us-ascii?Q?LTz+DlXuTsK8gDpGl4sF4xZtxl0n3tsVc85MQg4nvab8Ts+K23fqhTDq0Yn2?=
 =?us-ascii?Q?yiblVflxMFHreJ2yTb3H0zpaTQ6cGYRwvONOZED2nuBJdDcNLBscROi+JNrv?=
 =?us-ascii?Q?pK+/7kqJQnruPCSKRm+KRZX32sIcoG3RqqZzZLTVmEErPHtZ7OBgjgLBBF7l?=
 =?us-ascii?Q?25L0a9QFqxf7QKEHJ1pM/HNDXVAz+AG2ujWH1KANPviKj1Nk9i4cz0kFvHpG?=
 =?us-ascii?Q?qBY5oV9XVA//RPHh6xm7HYgpt11Bv/U2PGar6ftqx8qGFotL941EcS6n4pZs?=
 =?us-ascii?Q?K7VkM7i+Y5NU+MZlSz7BK8eHLPQPGIiiUdXiOGcu5JtdteeUsJTa9FKyfYcV?=
 =?us-ascii?Q?2lvJh7QdtClWo+IKZLLk9IM1IFOIeNCd3gJApaXju9tIZ7jnVRAQrTXpIUE1?=
 =?us-ascii?Q?Ldd1KLFHrMxq7Wb+lG5F2lsD0sLV0P5DvzqGWv5DrMufvueH6UE9BWdPyjmr?=
 =?us-ascii?Q?xy/Vp/0l5At/kWHV0ObMCweT4YvDyy8OxDLfbWqr3Fum7tlduOwa/nFmaatR?=
 =?us-ascii?Q?+3rxGEpuKamHDY7IKS8yKX1at0eph6eS/d64bnJr4WKu144spbBGJw8lpEXn?=
 =?us-ascii?Q?d89wdIj2PLSxOW3J4HX4eBH+cFZBSHWaLd2pljN5PdkIEyIyv0/WxfHZH4OI?=
 =?us-ascii?Q?9v6MVPq0OzYSc+rQHeAdt5yVCbze5w/OLrzhQZID3wijy38VrLwpudcflacQ?=
 =?us-ascii?Q?aRfL98gO6OzSWh0T2hfnATOvVp+kksDXrbtkFeKBoLJzXoKI3Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?30zMzPfgbVFmuUBend2BoCjTG2ODgi6LcKBgxRnlV71n5eM1pyI5oAzK6Fnz?=
 =?us-ascii?Q?KAeWIS9nCkj+LGH/xSummebzpYkT5uOL7iUBByRC2sb9jItaa6gC47Pf/1aY?=
 =?us-ascii?Q?LWMhX0APv7l7zK670QKOqMIi0loNjLFgr0SyMbRbbBPzKYAbR32DneLSv6cI?=
 =?us-ascii?Q?ZHDN2PApwiKsiVaM2saa6KcjHUM94KXgq6E+SeicYFMIRtQyeEj04G15uJXc?=
 =?us-ascii?Q?YKTeup3yUdIekFQgMk9lchdjYaHd5KzaeL8jQuyEOuNHozem1Uw8TnVR+gpp?=
 =?us-ascii?Q?8H8Y8RfVnYTB1l1jRxBf7Lh0EJ8LA99YzURhu1DFZHLxUldCjTclA9YQlVvy?=
 =?us-ascii?Q?VhxgXq7UwILxf3LElnTkjxrqHTUsBaxT6w42YVmFjTN4PlaGUgKYd4jgyIu4?=
 =?us-ascii?Q?qvORaSNTdiZRtC3GJxR6V2vISSkxGaAVSO0B9yHf1IWSOJB0CIPBoJx0blrU?=
 =?us-ascii?Q?DUapTMqzAT+P/nmUaxb5ztWo5LHfGLGh7zVLXj7UE0YZJJaPJw1KwlaTzEFc?=
 =?us-ascii?Q?7+Bra9ra2CglKM1RX+NS/eSgwQEECz6ymnNAoLfD6XLNZa4NGcGmzngH2DgD?=
 =?us-ascii?Q?ch+QT40oTqWQ9wUA5Eofu9M71S5+xu5YZanKXWAst1gYk53prrRuMgFFUzXi?=
 =?us-ascii?Q?WIAstDWEB/ZdlVL1+Or22esCAdd5Y/rARw57spFR+A49elKJ0hX2cDuMpHEo?=
 =?us-ascii?Q?5y7246x+KkVaXpgBhLhyW7Qv0HZVJUb304w+2HA7saxNO86fmEM64+7QlMxM?=
 =?us-ascii?Q?z3Mn0l1Z3YPazLD3ZdxxSz2dfS4C1wrYGQVL5KwYzWO8Oa7LPa2VrKrfwXwD?=
 =?us-ascii?Q?wNmDubvKnG03RACeU1MvfB8JujzcxR/y47qQOjbxYL8Y90BElTD7XiDi5oVD?=
 =?us-ascii?Q?uwjLb/lNuzKXmHEBoVW9CTu0YQbFqpvIzN1ZKanjBScr1U3LWZKtEAyYJfJq?=
 =?us-ascii?Q?hATnrU/IBIl4YagIJ1oVOQL7rgKH72/XvhccBsv1hEjciKTgnT7cHQZq4+jE?=
 =?us-ascii?Q?PtgOE+m+VATAnf7RslCr8SAxPrIm4nKCgLLag/eJgtNEWJn8sIRjwySDssIv?=
 =?us-ascii?Q?JzvFDFH0o9QFmwVeey2hiWGbo/DoiuknmQC9jvZBgb7WGK33MfxxVXA39U7b?=
 =?us-ascii?Q?1OBnVdVyQ3zIsfHHK91rZIVw0chYjcWT7K+cWPsaPtxbICjoixCT4dJfjMEv?=
 =?us-ascii?Q?t3pKNcvb/dOLS383mNUly4S5ZQiw/EJIisArErP4qEs5NEOxzY/BpcjJu5O3?=
 =?us-ascii?Q?G/bEnTCmf8p5h8Z8r7Q9AMFHLIkQfpUJpB8M4H5zc/ey5IxvWC91uKIbdHoQ?=
 =?us-ascii?Q?tATlZQP4l/6Ey966KtG2zw1MFE/xAS6wDSxYJJBbz8wXSbKlKd2gXeBF5Dr5?=
 =?us-ascii?Q?6FmLQeVRUUQ4FUdzKO+lLQsv1xu7dgy6irsiq9ETMh9ZaDQALAr4NChO2Qir?=
 =?us-ascii?Q?xWPHpLVRSQCtYUiYReGc+XK7gAE15/SeWvgf/Cfm7yI8uaxk0i1A9LQTiYiQ?=
 =?us-ascii?Q?ftIAVZ6jHID6/Is/tTERTQmSCKTxdZX/j57Ey/mtLXmQRau+WzdNN/jRVyv4?=
 =?us-ascii?Q?KBPUEaPJAtdkkCzY9Lg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19f23f9-b738-43e1-240a-08dca7396e14
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 14:53:48.0981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /kwhza6+SLop71+pr4U/Pl6gMS2seE0AN+b8u+XAqMwA/osbiSmc1IfNjM0guj/nOxioWdpHtp+gwvce21c+IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Ma Ke <make24@iscas.ac.cn>
> Sent: Thursday, July 18, 2024 7:06 PM
> To: Datta, Shubhrajyoti <shubhrajyoti.datta@amd.com>; Potthuri, Sai
> Krishna <sai.krishna.potthuri@amd.com>; bp@alien8.de;
> tony.luck@intel.com; james.morse@arm.com; mchehab@kernel.org;
> rric@kernel.org
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; Ma Ke
> <make24@iscas.ac.cn>; stable@vger.kernel.org
> Subject: [PATCH v3] EDAC/versal: Fix possible null pointer dereference in
> emif_get_id()
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> In emif_get_id(), of_get_address() may return NULL which is later
> dereferenced. Fix this bug by adding NULL check.
>
> Cc: stable@vger.kernel.org
> Fixes: 6f15b178cd63 ("EDAC/versal: Add a Xilinx Versal memory controller
> driver")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

