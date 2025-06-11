Return-Path: <linux-edac+bounces-4109-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4567DAD5445
	for <lists+linux-edac@lfdr.de>; Wed, 11 Jun 2025 13:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD7937A96F5
	for <lists+linux-edac@lfdr.de>; Wed, 11 Jun 2025 11:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A0826E6F7;
	Wed, 11 Jun 2025 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FOHX9yHQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6907269CF0;
	Wed, 11 Jun 2025 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749642161; cv=fail; b=UY3YLGt82fQ6WUi+E2+fOafIa/9H3oTg4i19DYmx3/Nv2psE3Lp4W8t9gzl3sf2jPd78AprjLv5UYZPeebvQjpPrxAErE2WYEGsApN5h/CRFyA1KTBbjho/iuF7+YJBtADJLbxk3XFMR/ekNMzUp6f3/IUlCWfCCCEFHBL8ecsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749642161; c=relaxed/simple;
	bh=5/0+xNfvdhkzg610SkFzSACZIWaN86Jil54YrRzACdY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=smfKTbKMcIc+JLUx6roWDmOJS2D/uoUiDhy9zrlYKErTdp4NbfgIqiXN9WCPmvEcpH019fhPOqOsYpE8uZdI+KKo30tXvRVurwXYT3d1LwhRpvZlEsxf6XOXzdsGrNBkppP5qINerz2ZVNSPIRybCzgSu38txeaRSpqOgq4LWbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FOHX9yHQ; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1zPcgvC+VCCdPwmF5HhkRDYkmES1T5ONKq2SYIRw0hFzSH6KfJXk2pXjAnrqqfTwfMxVUrV3ZwLMjeA4RDMjETSP6HPNU/OvWok2rNJx0VDKmltdp7WbN7PbtswP6YhXigJiWEV2d/+Vv2sup4Zt0Esd7I2y4hgUnmrNSkSE76/2KxYGsf74DBl6Alis3qgF64gXGxtaD5Nz4R4y4XP7flA6zZ6J1rN6UM4vuFcg/86Q6GeXLRYlyTPjT8EBcAsrF0+URKBXVekIpTpIa+NN+s/5qRZtvSQjL+m4NgamLEE/xk3pQA80RIK6rmTRZ6PXnn7j3nPBf6/TUwl/AKSUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/0+xNfvdhkzg610SkFzSACZIWaN86Jil54YrRzACdY=;
 b=cckByFPShpC5A0oHS5nAuoY0SdPCskk3nqLdlrf2F/Km5bph9789rssZmNd6bgHGbO+yfgmZkaTooSXxZCbG41wPjutdMNP04apT9E5l8I05DqVFGif3Zz8BrQSgGKRx41alZFzia93EVFMq9z1g9UQrVYl19vE1rhq7sh/mMeojDPABs9RP+py7GRry4kIF+xvQPNZNyvBVV4fK+t+hRhGj2CsPxSxte3+YgilxPMVI3jzCSbZCfaLncJocAgfYSBS9xQ21cZo5UIZHVkUf3vcT79Dg1tfKUVacz9sqbulRFozcfunF6H1rUV9yhUzcWp8otUJyXtmNzfTanrX2Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/0+xNfvdhkzg610SkFzSACZIWaN86Jil54YrRzACdY=;
 b=FOHX9yHQDHThJ7ezLjvAfFIm6JBh4OP2UiHnrlh+eizE3tWNju5nwWrPxURTj5GJ0o6oH5XgvzO16BHJdLJyj7XRNooSKyXGubWv1VApD1aez4CXh1oAz071OAgTKldjq9+UEopQb3gb0l2K17A5aUf7Pb/qPJA10eCtzJcEHQA=
Received: from SA1PR12MB8947.namprd12.prod.outlook.com (2603:10b6:806:386::7)
 by MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 11 Jun
 2025 11:42:33 +0000
Received: from SA1PR12MB8947.namprd12.prod.outlook.com
 ([fe80::8730:918c:b34b:d058]) by SA1PR12MB8947.namprd12.prod.outlook.com
 ([fe80::8730:918c:b34b:d058%4]) with mapi id 15.20.8792.034; Wed, 11 Jun 2025
 11:42:33 +0000
From: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>, "Simek,
 Michal" <michal.simek@amd.com>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Robert
 Richter <rric@kernel.org>
Subject: RE: [PATCH] EDAC/synopsys: Clear the ecc counters at init
Thread-Topic: [PATCH] EDAC/synopsys: Clear the ecc counters at init
Thread-Index: AQHbz53DeAbkSv25gk2QG9HHGnijYrPxLhoAgAFcYQCAAD7kgIALCYOg
Date: Wed, 11 Jun 2025 11:42:33 +0000
Message-ID:
 <SA1PR12MB89471067967E0A5F46CEE1DF8175A@SA1PR12MB8947.namprd12.prod.outlook.com>
References: <20250528065650.27646-1-shubhrajyoti.datta@amd.com>
 <20250603090536.GCaD664IbJB5IoR06g@fat_crate.local>
 <SA1PR12MB894764756C6538EE985BDE24816CA@SA1PR12MB8947.namprd12.prod.outlook.com>
 <20250604093735.GAaEAT39KGW1KJDrjD@fat_crate.local>
In-Reply-To: <20250604093735.GAaEAT39KGW1KJDrjD@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f0bd6b72-e6f8-4e8a-af89-2bc9115f8e41;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-11T10:10:29Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8947:EE_|MW4PR12MB7120:EE_
x-ms-office365-filtering-correlation-id: 2724cb11-a0e4-4a28-d7f2-08dda8dd0e2c
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RmlxZUxNVlpEUFcyMEY4NVRqcUJPYTVYZ1V2eTNPMjBGQTY2em1KVjh2Vklu?=
 =?utf-8?B?ckIxUFJOSmh5eTdYbU0xanpsYklSMVR5eWlvM2JOZDRwTDljZXQ5bWhXMkgw?=
 =?utf-8?B?dDlBWVVRTzBvRFd2dWYwSWw0bFZUOHd1azljYWI1NEc3TUhDVUEyTmk5elFk?=
 =?utf-8?B?L284c291eWpzSjJDVlg1STlrczFEcU9NVHBNWWwrbmh4ZHIvMFBtSjAwMkNs?=
 =?utf-8?B?cjFWQlloSk1mVjgyT2d0T0RkTEZTZjNEYTNEb0wrTDQ4Qit6MEUxSW1PbUpJ?=
 =?utf-8?B?RlZnUDhjalI4alVYYmprSi9pY2NVSlpDYmpXeU1jdFpXRERrb3E4RkJhQXd4?=
 =?utf-8?B?N1pVck5jSVR3czR2RVdkS1hhK2lFQ1djRzhlcFc2SXI1U3UvdCtsVDFHN2xU?=
 =?utf-8?B?d2h0R1FTR1lKRkZ4YnMyVEZlaUFwK1h5eEcwQWo1MHB0a0MyZi9jTEVyVkVm?=
 =?utf-8?B?dWg4dSt3NXgweEZ5VmpnaWFWcy9IKzdibHNnbDFUamQ5Rno5UitPTXl4cWVs?=
 =?utf-8?B?dnc0YmNYdTZzVmNwekZITmErYUhBUmNPNmd5Y1g4Y2l6NmF1blVTalN2VHc0?=
 =?utf-8?B?OUtKZmRWd0Q0NDZoSE1YaUh3K2pXV1JZRzhsWStmM2pCbkVDZGYyajhMRlZW?=
 =?utf-8?B?VFlEakV5TmVGd3F5Z3JxemxpdHBNWHdLK1JBUGtDNjh0RkxmemtvamlES201?=
 =?utf-8?B?SUo0MzVIdC9OL0lvK0ZZcjNoOEJDdjZnMVlSV1Z6bjg4TWVDNFcvUGdYYmRz?=
 =?utf-8?B?aGxNV3pscC9BYlY0d3RmdE96SlFjT0lyQklQa0FGaEJlR1pUVHNKdW44Ulgz?=
 =?utf-8?B?ZVIyeWIzcnpHOW9BL29iTmlxZkZLQjMyMHlid3VRd3h6bFc4cml4WUhkQUZj?=
 =?utf-8?B?bGV3SVR2WXRkTWxWTmNXNlZRMHhzVVMxazRHTTBTU0lWY0VmcFR3a3V4V1BV?=
 =?utf-8?B?U2dGWnNQcDBneFFOVTQ2T3dWdGN2NDAvSllpVFNFUVN2Q0JLcHVrckcxT25U?=
 =?utf-8?B?NElXRFZBTzV1ZEIrQ3ZxWWZ3UHJWYXlsTmhTaW1OdFdscmUyaTRJRnEyanps?=
 =?utf-8?B?ekZIcUZoQ05YaS9hUFBsQ1Zhaks0NXc5cHJzS0xLTFV1dksrYmIxSGhEMS9r?=
 =?utf-8?B?VTFKMU1KbUpUbFIrZDlVV0dhaUJBaW5hUGVwVmNMWVRtQjdLQnRZTmpFY1d0?=
 =?utf-8?B?U1gySTR5SllvOXFQQTA0aC9SZFA0bkt5aUNrZFZ1czNjQ2JPSWRpL0ZVSmRK?=
 =?utf-8?B?RDBId29lc0ErY0tNZTBneGxGOS81VzA2bHNaUzZIN051a1RmeExMR1pVQ29G?=
 =?utf-8?B?WTE0VGxiM04rNTJ3SWoxd3pVcTVCS2hqZXJ2b09Zb2ZsNGhaekMwTEFMcHVl?=
 =?utf-8?B?NnUvM0JPeHlOTTlkSTJMNWJIYXJEVVRTaitBZTRIUmdReDlrRG9CN0FrOVcy?=
 =?utf-8?B?TGdHT1FOKzFTUjRyUEg1RU9nTXNHNEwwUDhROWQ3bXhIa3VkYnl3K2hkQjZX?=
 =?utf-8?B?enZERndnREs1NkFsWk9nQkdOM01Kc3drTEx6bjlSWkhMOFo5b3B3K1UyZ002?=
 =?utf-8?B?dUROT2ZnbFMvMGNldlNobFNsRTdXNnlGTkNFQ28vT1dONFNqdE51bS9xajFD?=
 =?utf-8?B?OE5PM2lVbjVRQm1TYldOUHFCRVlVRU0xQ2xXcjdGSDJQZENkOEhQQVJySnZl?=
 =?utf-8?B?RXU0VmttQlBnN3kxaEN5aUozL2dCbkJQdGM0WkVEWmkxOFk4Q1lJaXhpbTNq?=
 =?utf-8?B?alUraWt0cjR2cjBkam01L3VxUDBCVnhEcW1jU25aS09oaUw3dm1ncmpCT3Zw?=
 =?utf-8?B?Kzcxd0pYN2U1Yk5vTkcvSWRRR2RYdVVYR1M0QmxWOFRJeXFueFVBazBoYmFk?=
 =?utf-8?B?MmVOdmVyUktHMmVCN1lpeHRRcG5vWm9vTVgxVGR2UFhaM3V5b1hTSFdxR1dS?=
 =?utf-8?B?c3FqTDlXaUJIeWN6OXR5TDd3N0Y2QUd4WVgvYkNNUGQ3SjFKeUsxTUltTW5v?=
 =?utf-8?Q?Uh+fbaO2HOUKc+fxuVXKHCZqxwT0KI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8947.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SUZPUkFDVjVXdm9CZFU2U0duUzYzVVVSL0krYWtEd085SHVkL0pZdlhtS29D?=
 =?utf-8?B?V3R1TGVMYnRzME5VSFZlUnBZeUl3K1JyYUpQeVdGVFRPUGpGTG5hemlzWEQw?=
 =?utf-8?B?US9HRkpwVGNXbC8rRHpzMm55UUIvNkFhMmMzOGVIOWVoTk1PbSs2RUdKMjRm?=
 =?utf-8?B?Qjd6L3JuWmo4aXdPOU1OamZ5eGl2OGpiaVRuTi9nNjdFM21wRkxuYjYzSENu?=
 =?utf-8?B?clhjMllUcEtyU3h3NDRoSU5xOFJid0M3VEdFVjZ3a0xkQWlTUGc5aUZxL0lX?=
 =?utf-8?B?emYrNDZGVzVieXUwM1hJVGFrektvNmc1MGNVU3p3SWo4YWFZNWN4dEZJZkZE?=
 =?utf-8?B?M00wM1NGM3JzRm45dUJUbDdoRFl3SGZuNEZBTzhOL3dzbzRheHA3eXFGazdW?=
 =?utf-8?B?MUQ1Y1JZYitRV1pEc1JPR2hUNS9kZHlPbnBqKzdNWGpPdDZ3eXVHOEg0MHBa?=
 =?utf-8?B?MGJNZGQ5OWkzQjZEN1ZQQ3h0Zk1yaytnNUMxQy9YaDNsU1gvUTBoNlYyWU5X?=
 =?utf-8?B?YkpQVXVib1pNdVlLMjZSZERIZFp6QnNxOFA4NjcrSlBLTnBlUEFxT1hFUFdJ?=
 =?utf-8?B?N28wSituU3JHRnpOaFQ1dGtPektGNEx5L0ZGL2tsT1hON0hSd0hkYVF1Ui9n?=
 =?utf-8?B?cmdFRGtvalYxMDVBdjlwZDJLemh4UzYwaUpRY3hiaEV3K1JHUHNETzZmL1Mx?=
 =?utf-8?B?citBOFVGM2tYRDVQMUpaeGs4YVdMclNHL2U3ZGplbCtmTDFvdkJmb3JPeVhj?=
 =?utf-8?B?cCtlU2Z4bXZoRWErTXhBRFdLeWtKRzdYQWQydjdnRzJiWXBLa29uZ0N5RjlF?=
 =?utf-8?B?SUJVV0VrRFVkSzlBVlk3VlIvUXh5Vi84WXQvb0tQcWIvNndMUWJNRm5FbE1F?=
 =?utf-8?B?N0RGeVR1QkUvT05vT1FudUpXeXFJMkhDbnlhV3dBVUl0OGMzZlVwZlJ5ek4z?=
 =?utf-8?B?YnZCN2FPL3lyQm9lVUJSdzlmZTlmMjZ4b2swcGNXVVFvMW1DVW5FTGlNc1hH?=
 =?utf-8?B?M0RkYVNnYUtCaHM1aVk5eUlUMVhpVVVWVUNtSDgyQ3paZmxCU2lzYTVmNnMy?=
 =?utf-8?B?RGprcG4yQlNJWXNCZ1gvdDk3NjVuMXgvZ0dPRFBLbWxBSVA1cHRjTUNDMHRK?=
 =?utf-8?B?SXkzWnFFT3djMjBFS25OOHlMdXpHZFlvRnB1V2lMbkltdVIrQmJrQ2J0cUg1?=
 =?utf-8?B?ekd6R0owNExmWVV4TEt4ajdNeU14Y2NTVk5pVi9ack5zQVFDdC9CUGpzQmhW?=
 =?utf-8?B?aGIyZG41Wmk2QkNpU0FLVjZpWUl4a0dRUkNTRDh0VCtQMFEydkJDY0dNRTNQ?=
 =?utf-8?B?N1E3aVhURGN6VTE2eEROV3BYb1J3bFl5ZmtWckw0d0Yyc1gzT2t0aS9LWGRW?=
 =?utf-8?B?NzhmMzhEZFNqWkVVbTRVaVNKYUxCbjJzTzBtR2tkTXdGVFhPQ1JSeHVTTm9H?=
 =?utf-8?B?VkZxOHVhOU5MSWdic0VLVmVwdndpcTFxTUJ2aDJRVWFhODdzTU5yUkN6U0tT?=
 =?utf-8?B?SDN4RjFkVkl5WmxvNjFma09henkreUpDeGphMU5LeVkzWHBJUXNNSzZiV3M3?=
 =?utf-8?B?K3pxUHFTTmVFb3NkSXROK05qbE8rQjZJazY0TDZlVmtvN1J1RitaS3Y4Qms1?=
 =?utf-8?B?WHZTbGRtV0RhR3BKMGRTNzJkRnQwM0hSQmZUUTR0aFBHRERxWUtaM2U0OFRW?=
 =?utf-8?B?eFl3NjhBbUtVUFRaeHN2cUpRWmc5aFd3MC9XM202c1FiL0p2RFk2L3pTYzZ5?=
 =?utf-8?B?M2pTVWozekE3eVp5ZzJtWGJOSnNHU3M1anZFRURsRE1aazBjY0liNHRVNDVF?=
 =?utf-8?B?S0VIeGxBWEpiS3Z2MEY4NUFkWDRWSFN4cVhHZzFVaC9PeUd4dmd1anBlbzJX?=
 =?utf-8?B?R2NTb1hRQ1BoMW0rZGF1MndPSzFMaFhVZ3hTRU9hTSs3U1hQeHFsbUZ1Tm45?=
 =?utf-8?B?c3FaNW5lVTVONFFaTExvVlpPelFra1NFbDhQcVpIdVJqc001ZHVHSXl3eGt3?=
 =?utf-8?B?cncrYW15YkwwUW1lS3RHM3JyV3d2OGNnY2prVXUrcGRJNitDZEtBdU5oRnRa?=
 =?utf-8?B?V0I4TmZYc0hlejRHYldkZHFaWEVkTlg3RTFoV2puOHMxdmw4SjZOU0pZZW1z?=
 =?utf-8?Q?idTM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2724cb11-a0e4-4a28-d7f2-08dda8dd0e2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 11:42:33.5383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OZnjZVXQE1DmubagIxtuqdDP9SotTD785ku7kljjgc35ML9cRRQuuKFGBP7oy5Hz/vRBgnFENo7TXzjs4B31IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDQsIDIwMjUgMzowOCBQTQ0K
PiBUbzogRGF0dGEsIFNodWJocmFqeW90aSA8c2h1YmhyYWp5b3RpLmRhdHRhQGFtZC5jb20+DQo+
IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWVkYWNAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgZ2l0IChBTUQt
WGlsaW54KSA8Z2l0QGFtZC5jb20+OyBTaW1laywgTWljaGFsDQo+IDxtaWNoYWwuc2ltZWtAYW1k
LmNvbT47IFRvbnkgTHVjayA8dG9ueS5sdWNrQGludGVsLmNvbT47IEphbWVzIE1vcnNlDQo+IDxq
YW1lcy5tb3JzZUBhcm0uY29tPjsgTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFiQGtlcm5l
bC5vcmc+Ow0KPiBSb2JlcnQgUmljaHRlciA8cnJpY0BrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBFREFDL3N5bm9wc3lzOiBDbGVhciB0aGUgZWNjIGNvdW50ZXJzIGF0IGluaXQN
Cj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBT
b3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNs
aWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBXZWQsIEp1biAwNCwgMjAy
NSBhdCAwNTo1ODoyMkFNICswMDAwLCBEYXR0YSwgU2h1YmhyYWp5b3RpIHdyb3RlOg0KPiA+IHp5
bnFtcF9nZXRfZWNjX3N0YXRlIGlzIGdldHRpbmcgY2FsbGVkIGZyb20gcHJvYmUvaW5pdC4NCj4g
PiBJIHdpbGwgdXBkYXRlIHRoZSBjb21taXQgbWVzc2FnZSB0byByZWZsZWN0IHRoZSBzYW1lLg0K
Pg0KPiBObyBuZWVkLg0KPg0KPiBOZXh0IHF1ZXN0aW9uOiBUaGVyZSdzIHp5bnFfZ2V0X2VjY19z
dGF0ZSgpIHdoaWNoIGlzIGFsbW9zdCB0aGUgc2FtZS4gRG9lcw0KPiB0aGF0IG5lZWQgY2xlYXJp
bmcgdG9vPw0KWWVzDQoNCj4NCj4gSWYgc28sIHRoZSByaWdodCB0aGluZyB0byBkbyBpcyB0byB1
bmlmeSBib3RoIGZ1bmN0aW9ucyBhbmQgZ2V0IHJpZCBvZiB0aGUgc2lsbHkNCj4gZnVuY3Rpb24g
cG9pbnRlcnMgY2FsbGluZyB0aGVtIGJ1dCBzaW1wbHkgZG8gRUNDIHN0YXRlIHJlYWRpbmcgb25j
ZSBpbg0KPiBtY19wcm9iZSgpIGFuZCBiZSBkb25lIHdpdGggaXQuDQo+DQo+IFRoZSBkdXBsaWNh
dGlvbiBoZXJlIGlzIHZlcnkgbXVjaCB1bm5lY2Vzc2FyeS4NCg0KSG93ZXZlciB0aGUgcmVnaXN0
ZXJzIGZvciBaeW5xbXAgYW5kIFp5bnEgaXMgZGlmZmVyZW50IHRvIGRpZmZlcmVudGlhdGUNClNo
b3VsZCB0aGUgdXNhZ2Ugb2YgcXVpcmsgYmUgZmluZSBjb2RlIHNuaXBwZXQgYmVsb3cNCg0Kc3Rh
dGljIGJvb2wgZ2V0X2VjY19zdGF0ZShzdHJ1Y3Qgc3lucHNfZWRhY19wcml2ICpwcml2KQ0Kew0K
ICAgICAgIGVudW0gZGV2X3R5cGUgZHQ7DQogICAgICAgdTMyIGVjY3R5cGUsIGNsZWFydmFsOw0K
DQogICAgICAgaWYgKCFwcml2LT5wX2RhdGEtPnF1aXJrcykgew0KICAgICAgICAgICAgICAgY2hl
Y2sgZWNjIGFuZCB3cml0ZSB0byBFQ0NfQ1RSTF9PRlNUIHRvIGNsZWFyIHRoZSBjb3VudGVycy4N
CiAgICAgICB9IGVsc2Ugew0KICAgICAgICAgICAgICBaeW5xbXAgaGFuZGxpbmcgLi4NCiAgICAg
ICAgICAgICAgIENoZWNrZWNjIGFuZCB3cml0ZSB0byBFQ0NfQ0xSX09GU1QgY2xlYXIgdGhlIHp5
bnFtcCBlY2MgY291bnRlcnMuDQogICAgICAgfQ0KfQ0KDQpBbmQgdGhlbiBjYWxsIHRoZSBnZXRf
ZWNjX3N0YXRlIGluIHByb2JlLg0KPg0KPiBUaHguDQo+DQo+IC0tDQo+IFJlZ2FyZHMvR3J1c3Ms
DQo+ICAgICBCb3Jpcy4NCj4NCj4gaHR0cHM6Ly9wZW9wbGUua2VybmVsLm9yZy90Z2x4L25vdGVz
LWFib3V0LW5ldGlxdWV0dGUNCg==

