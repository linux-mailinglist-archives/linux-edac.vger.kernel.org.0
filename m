Return-Path: <linux-edac+bounces-1477-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A8A92C471
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 22:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2941C2205A
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 20:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF832185633;
	Tue,  9 Jul 2024 20:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cqCkJ/OW"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089B9182A5E;
	Tue,  9 Jul 2024 20:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720556620; cv=fail; b=KSQK3syRlUrBJc0DOiZu5Sgf0IYHqi29OXctOB+yDyxNUbVJLFKNyYqImScPU290OwN3lBpt9ks6/CnASYH+zWa6nyy2wPpD0woRWNOuigdSwm8aZ9RoVTGcCulGWJlsI+2wCgDlYfOT070S4eVYbOP+INdxMz5vi7uyy1IsQE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720556620; c=relaxed/simple;
	bh=QNZOx5eJVCU0W7EZ2hHtejXRuENDwxZu91LDUv0owoM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=g3AsKt8jaFMel1zTbFUo6yfERWc57wdTKcbhDgfTShSP7CWX6jeDsPy5gVsGgv2DtH75bWwFQ61Ix8MN6GMKlJ/pCjZYXvsZdQxvZUug79EOxSSAEQZsf/XLOtS6sWeLPSSzv7UQYh1IsNg4DeEZmrL6iZPSf+TofqB45zVfXfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cqCkJ/OW; arc=fail smtp.client-ip=40.107.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlpMYTz1WIhrbqpwQxRNAVXa5LgMyQ05R55zexLA1jXyzUP94FyXubKVxI57k1zGWgwbPUmiEPgqWvOIMwjONISIaMprzi9OR7UgHaUheemnmv1hANcixAlaj434b1rVN9taBskiS/FI+4Kf6vShBMzSpQ80S2m+vUtR+qW+CdSbR6qa2B+qzvWSIjUjWY8foQpFU5OY+FlgPgJVxTaW88NFTn6AbuLqxDAcLKKrbbjEYZookwtHpKW+YBfjoYWFuwPjV6Fo6t/MqlkeDBOAwT7bOfJ0YbOupNWgv65RrUp9KdJYeIHgZysvH7LLROrXR5WOw/SBK80K6IQNf93bUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JA819jqoPZrn1JnIi72gwTFnZaIouoJzS/nUgbAKfqM=;
 b=l1GUnb9LKTPfgoHjdg5deb073YOPSHDs7W48H9pNYcbY5fWFYU+3VeCQceKWuv1S5ChB8FC1vOtthmQTjIuWoffDh+2y1yCzHTI3rJv0S7t2eKT2e/XOTp/Kg8OaXhzjeWnEtmFD4w9dwRGDyyxdUCMmzbVvUeGMMtx5WLb94ABPelUDM5beERp6dqcxjZ4WLOQB5Q7/qkbACYdtSgN+lhYt3bGyouZkURKk1TZH+o7JL3d8txMsEpv0Vr2feV3pvAsckIvStnhqeUXfSwN1SOMNDBm/mTymuxjLYqmKAGNIXHct/52L2JhXplqqh2FGZvQZiaYq+4ijBDfdp3gCMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JA819jqoPZrn1JnIi72gwTFnZaIouoJzS/nUgbAKfqM=;
 b=cqCkJ/OWY1ypIvbQm93oSumEqpAVgH89vtyQLcdDUKejuyZlGKcVmCg3xum9tnfeDDDApNdxq/oTsmjz0+QSG7eHPsyCMLAMR2reCHsJzJ3ptaYITHptOvdTRaS0kh1t2nSAgP0eO/QWQoFrVmtC9kDodG1JocxvbNXn9S63a5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8267.eurprd04.prod.outlook.com (2603:10a6:10:24b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 20:23:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 20:23:37 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 09 Jul 2024 16:23:03 -0400
Subject: [PATCH 2/6] EDAC, fsl_ddr: Move global variable into struct
 fsl_mc_pdata
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-imx95_edac-v1-2-3e9c146c1b01@nxp.com>
References: <20240709-imx95_edac-v1-0-3e9c146c1b01@nxp.com>
In-Reply-To: <20240709-imx95_edac-v1-0-3e9c146c1b01@nxp.com>
To: York Sun <york.sun@nxp.com>, Borislav Petkov <bp@alien8.de>, 
 Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Robert Richter <rric@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Borislav Petkov <bp@suse.de>, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720556601; l=3448;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=QNZOx5eJVCU0W7EZ2hHtejXRuENDwxZu91LDUv0owoM=;
 b=02ZNyms3Nt0w9tn9oyTolLLBuW7enItXsYUKkZGHONgeXNOpVfgJiBo2QYpuUpDj3Y+FDVvt4
 Zv3n/DEGv7UB+aiJNfULpRb6a73izM3leYPYmDM6FUVCtpvMb5msd5a
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::46) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: 6874fe9f-9f85-4ee9-21dd-08dca055037f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alZFamEyNVpDcjBIZzhYUXNIMVB3UW44YkJRRVJVcGhNTG9pREE2aExmTU8y?=
 =?utf-8?B?NGpiRUpWZ0RHTkNKODJ1ekJjQnNrZ0FnRDZNUEljdnRjWU84OU9SQ0tmUmNC?=
 =?utf-8?B?Q2J2K0xyaXpJY2FwVzF6S2hXY2g0Y0V0Y2NJRGdqRkFuU0grdm1Ya2xURGUw?=
 =?utf-8?B?d1BjVnkzSHEyQUp3L05zb2FiZ0E0dmFBR0NhekJoZ3VzcHE4UGFFdTJaaHVG?=
 =?utf-8?B?SjBCNDdTK2tTVDU3SnVrTWRXVkZhN25INzZmWE53cFRBSUJnd0tYTUorWUtL?=
 =?utf-8?B?VUEvTVZKNGk2a2NIbzJlNDJvVEtxejVBTjlldkdNQ1dyWk4vd0laQWtEWnVu?=
 =?utf-8?B?YVBJUXZjRmhic2hKektlWklMQ3hka05rS0VrZE9RZWNaOFVaa21Cb0lJOUh0?=
 =?utf-8?B?KzUydDF0QXhncHBmWXBYUFIzRDlad3VvWFJXUU90UERFWlhhYUNWU3FNR3kw?=
 =?utf-8?B?REVCeHdqZ1YxdVorblFhQVpHMEQzdFdPeFNGRTR6VG1rYmtnRGp3TUp4blAz?=
 =?utf-8?B?R0h5VDduK0ZGTUIreEhwOUdDWUl3V2owZmFlbEJ0dHdQeGwzSzFTQXFXOWM3?=
 =?utf-8?B?ajFEWXQvdGVxd0NzcjByQ1NqMWdPaTg4UG9zQkszZVpVbytQcE9rNStWTEdu?=
 =?utf-8?B?bFdVNjRRVDFjZGVJSlo2bWpZcGlJaExXbjJIckRvUk5UaFlVUzA4MlZlc3ZO?=
 =?utf-8?B?NUtlb3NiWVJoa0NmVi9tOTVMMEgyQ1JpcGJDZmhyWCt5cUpjUUNaTlhORHNR?=
 =?utf-8?B?dHcrSnhzbUVtT09XMFJlOHBrVzFSdW51TnhVZEF5MXk4eW5JdFhDSDlFbHJK?=
 =?utf-8?B?U0xnSWJtNFpuYWpaR0VTZU50bEdDU2YvcEc2TGlZM1Y0ZXQrYyt3NG03NHpr?=
 =?utf-8?B?QUp2TEY3UCt1bGd3RWt5NVlTaUtwbkF4akpQZGtBMHpuTGhreExGd1dKRnFq?=
 =?utf-8?B?VTM4MGN1TVhnc3VnM0FiOEdQY1pWc3l6TzVLQ2srUHptbHJIZVkrNUJWUThj?=
 =?utf-8?B?TkY3U0thKzVnZmpwMCtiN1F1MnZTanlYVlI3TkQ3N0pCSllCa0pQemlsMUZR?=
 =?utf-8?B?aW9kRjNLUnhLL0Q1bnpnRFMvUklReVU1dmJLSlR2YjZGMVZkQW0yMU0raTZt?=
 =?utf-8?B?VnRyT0JYK0MzRU1QSjNSNTJoTk9XTDJSQmh6NE9temJzREdCWStBYjVrN3hr?=
 =?utf-8?B?NGlLakl1dy95aVlCV21NR1lTWFAvWURDS3B6QVlUS0JrcTBLNzhyYlRyME16?=
 =?utf-8?B?K2NMVmw1RWk1TlFaVXNaQjNiT3BFNjFEYmtKRnhRb2FZMmxNRzg4bzd3K1RT?=
 =?utf-8?B?NjdpZFRYYk5MRlJ3TEVCbjVLU2l5RnRJZHBiazB4T1pzZVlSMW42TlMzb0xU?=
 =?utf-8?B?blpOSGo5RW9mY0h4MGtmcWxyN3hOVHdsRktPWk83MEVvb3NPMnk1TWVpTzFM?=
 =?utf-8?B?S0hsZk9OQkJQZFJhZ2ZhdFhxM0pLM3ZrZi9NTnc5MDJYRzFqSnBZNmk0V1F2?=
 =?utf-8?B?Kyt5ZXdOcVZXdVZaOFdpQ3V5c2prOGZPdy9LcDJzbDU2MXF4QzZSU3d6S1ln?=
 =?utf-8?B?OVZQN0k3YmFQRDFKbzRKeit5MldyRzhEU1NEOEJQUnJBQk1BdTNDRmMrUE8y?=
 =?utf-8?B?ODM0SVIyZHREajZqMzU2bStIUTFsck93V2crelJBSWJYdmZaMjc2WXNka3V4?=
 =?utf-8?B?SWlScTkzMXVJOVJGZC9oa0ZkSGl1OHQ1clNNU3JPRW9pYWdQaFdYUmxUcHZo?=
 =?utf-8?B?RjlROFRkM0VkNlN6YnBZQjU4NEtkQzYvNEJhMmhwWVNRaWVIdWExb3ZtNWsx?=
 =?utf-8?B?VTZ3clhkbVkxdTRrTjllUVArSnFPMWlObE9zbHIreUd2bWN6Q09KYXQxejcy?=
 =?utf-8?B?K3M4c1UxSjM0TS8vNWpPVGtDSjd0VFVZdFd4Q0habGNYM3UxVE55OUN2THln?=
 =?utf-8?Q?P9u0LIeQh5A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RURZN3dxZ0d4cU1kZC9HRUVZd29Ub0RxUnNOejhMVG1xS1JqK1ZxSXZmR0g5?=
 =?utf-8?B?QTNheGV2dlVzR1l4WDBzTWErQnFtbkltOTJjZnFOeWJ1ZUNUK052MjRWSTZz?=
 =?utf-8?B?eWxQS1NZV2ZZRTg5QmN4ZU80Y1BmQlo1RVFYeVNJbS96T1lBZEYwcXpEejlv?=
 =?utf-8?B?SU1xOHRYcWsxajVaVnIxZFhUS2ppMnFnWU1ReWFqakZ3VU5oS3diTFJqQm9E?=
 =?utf-8?B?c1JGQVA4U2dOb2dQMjBIVW9oazNLS0VJRzlDbFgrQ1cxVGZtRjhkckh3Y3d4?=
 =?utf-8?B?Qnllc1FoM1Qwc04zSkRKUU1UTFpudHFzUU4yK2VDRkVjUFJKZWpkYlQ2RHNp?=
 =?utf-8?B?RGpSVUpmMytJb2V0R0Qrd0Y1TS92MDR0bXk2S1FNY2NPeTF6a1JYb3NUT1k2?=
 =?utf-8?B?VjVSZDlNQ09IcWYwTFNQSkVFb0lMVDZubkt6SkhZQnBxdzJQYmg3L0taT0RO?=
 =?utf-8?B?WXk5ZzFRdXV2OGl2dWRhWGowYTBVN2JxaUk5Y3F2Z0IxZ1Nsd0xoMGJLL1NS?=
 =?utf-8?B?MTJBU1doK1pUQ0dTUElnUlVHVllpbnlwU21hVUFhSVRZZWJ1R01jaDBxSCs1?=
 =?utf-8?B?N0ptUWlmN1E4Y0dCTnJneVNKMlJjU2JpNndaWWVONFpIcWNRUGQwb3VwVVYw?=
 =?utf-8?B?WXF3NHVWVEFIbDh0YTlUd2gyTVM5d1hER3NnMXNxRmpRankyS1hyM3Axai9Y?=
 =?utf-8?B?V21GZkUrN2xqeTFNRWlaS2Fwejlya0ZuOUYrQUx1Y05ocTJiSmZERllGR1Ft?=
 =?utf-8?B?NVRCcFVLMlJnQklhOEd0Q09TU2tkYjRnUlR1QUl4WDF2T25oQzB1ekdIZUl2?=
 =?utf-8?B?MlpLdVJnSkV5NTJiRUZQVys0dmt0N2Mzc0MwQ2I5UWQ5VmdzWlgxdWlFL0VJ?=
 =?utf-8?B?a09lK3Exajd2bXdXOUUrMUU2em4yRXlUTU9WazJxTGRFRHJEMHRhWmQ3c0JG?=
 =?utf-8?B?VWhma0xuUklBYzQ2clNQUTQyL2pFb28xcHoyQ054OXcwMFBhTWhodlJrU3NI?=
 =?utf-8?B?YzRmK1pOYlRyWUxYTFdDbHNqKzlBYnNCbmJLOWpmU3UwMUE5SkZRR2ZSWjE2?=
 =?utf-8?B?SzZwN0xFbzJUbndreU1GM1g3SHNHZ2s3V0xHWXFuY3VnTHNRUkc3RVRzZFQ5?=
 =?utf-8?B?aWFrR0tUV3UwQ3R4MVJMVXpRQURWYllxQ1JMZlpHZXo4bDlrUW1wbjFkN0lt?=
 =?utf-8?B?VTNOQWlOenZLM1FEUEg4TE1rRURTNDZsQWxsYnZqNnl1UFFDQmNDMmc2WitC?=
 =?utf-8?B?VG8va1hibkY4Tjk5Ty9ZbU85N2didXhTMStoSWNtVnJYQVk2RlhIQTNPTFd1?=
 =?utf-8?B?NTV2N1Z6OWxOQ2FnM3FNU3BUeGNaSERHaFZmeXdLYTJpY3R1c0hsVUhLK1Vh?=
 =?utf-8?B?NWozTGxIMUhqeHduTTZ0c3c2bUUxOWlEbENlRU9HdmV0K3N5dkpTd0tBdEtO?=
 =?utf-8?B?c0lpb2VYL1lNUVNyUUN3YTM0K2wxdGxIcEs4YmEvR25GZ0hzcTV1ODZ2WGZh?=
 =?utf-8?B?ZDJFYWJIdFpKZzllMC9JSkdwQjc1Yi80K3g4UU5XQjBmNU9CSmhiaEhFd3pF?=
 =?utf-8?B?Y0RRbWp6MTNuSjlHNEtQb01Yajh3cGdodXorTmRYa05qeHByZ3k1MkkyckVM?=
 =?utf-8?B?ZVFtQnVjMDZGR1AxNjZTa3MxRWNwUlpNQ2dKUk15MVFyWllEdzVyNEl0b2lk?=
 =?utf-8?B?b1pWWHBPR3BPS3ZRV1FOUVhYaGlaUGoybWJFZHkrVmJJUGxZYlJmUzk5NlJD?=
 =?utf-8?B?a2VvZG5mODFHYUdVSU5HTUZnRDhsREZNU3dvSTFYcWkybWVHOGM5amxHTkx3?=
 =?utf-8?B?ZmJBT0hBbWJERFl4UGJHQ1EvajZ0d3MvZzJyRmRsMFZ0aEVtV1pnVkFQbit1?=
 =?utf-8?B?K2w0cHVYcGFOUmNWaHlsbkZUaEdmbVkwYmZ6MWNrbXEwOXcwcjNNa2YwZDR5?=
 =?utf-8?B?a29EOFlZRTMzRGJjUktqQ1czVUFQVzZQaUNTYVlkU0RxT3RMUUw2TWVHN2hZ?=
 =?utf-8?B?blM2cGNVN2F5UklFbFlIZFFVVzYrcTd0WHNIQzlWK25OemZqRE4vRHRPUFRP?=
 =?utf-8?B?TFgyVzl0YURpZjI1TnpQM1hyN2ZKajU5SVVCZWhqdlM2R05WelJ5dkQrSDcw?=
 =?utf-8?Q?DIL/+7wshT/3D9vjCRU39Qofa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6874fe9f-9f85-4ee9-21dd-08dca055037f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 20:23:37.1945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujC/chjcQ0TViU10DIsngJX9IwhCxlfZYTfoWiEfMW19bLPSArC1JQBuPDvmNyaRjMeIJUfAU2RCKHSBtyikoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8267

Move global variable into struct fsl_mc_data in case there are more than
one ddr controller in system.

No function change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/edac/fsl_ddr_edac.c | 21 +++++++++------------
 drivers/edac/fsl_ddr_edac.h |  3 +++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index a7982370e2381..10b0a46669f3d 100644
--- a/drivers/edac/fsl_ddr_edac.c
+++ b/drivers/edac/fsl_ddr_edac.c
@@ -31,22 +31,18 @@
 
 static int edac_mc_idx;
 
-static u32 orig_ddr_err_disable;
-static u32 orig_ddr_err_sbe;
-static bool little_endian;
-
 static inline u32 ddr_in32(struct fsl_mc_pdata *pdata, unsigned int off)
 {
 	void __iomem *addr = pdata->mc_vbase + off;
 
-	return little_endian ? ioread32(addr) : ioread32be(addr);
+	return pdata->little_endian ? ioread32(addr) : ioread32be(addr);
 }
 
 static inline void ddr_out32(struct fsl_mc_pdata *pdata, unsigned int off, u32 value)
 {
 	void __iomem *addr = pdata->mc_vbase + off;
 
-	if (little_endian)
+	if (pdata->little_endian)
 		iowrite32(value, addr);
 	else
 		iowrite32be(value, addr);
@@ -511,7 +507,7 @@ int fsl_mc_err_probe(struct platform_device *op)
 	 * Get the endianness of DDR controller registers.
 	 * Default is big endian.
 	 */
-	little_endian = of_property_read_bool(op->dev.of_node, "little-endian");
+	pdata->little_endian = of_property_read_bool(op->dev.of_node, "little-endian");
 
 	res = of_address_to_resource(op->dev.of_node, 0, &r);
 	if (res) {
@@ -535,7 +531,7 @@ int fsl_mc_err_probe(struct platform_device *op)
 		goto err;
 	}
 
-	sdram_ctl = ddr_in32(pdata->mc_vbase + FSL_MC_DDR_SDRAM_CFG);
+	sdram_ctl = ddr_in32(pdata, FSL_MC_DDR_SDRAM_CFG);
 	if (!(sdram_ctl & DSC_ECC_EN)) {
 		/* no ECC */
 		pr_warn("%s: No ECC DIMMs discovered\n", __func__);
@@ -562,7 +558,7 @@ int fsl_mc_err_probe(struct platform_device *op)
 	fsl_ddr_init_csrows(mci);
 
 	/* store the original error disable bits */
-	orig_ddr_err_disable = ddr_in32(pdata, FSL_MC_ERR_DISABLE);
+	pdata->orig_ddr_err_disable = ddr_in32(pdata, FSL_MC_ERR_DISABLE);
 	ddr_out32(pdata, FSL_MC_ERR_DISABLE, 0);
 
 	/* clear all error bits */
@@ -579,7 +575,7 @@ int fsl_mc_err_probe(struct platform_device *op)
 			  DDR_EIE_MBEE | DDR_EIE_SBEE);
 
 		/* store the original error management threshold */
-		orig_ddr_err_sbe = ddr_in32(pdata,
+		pdata->orig_ddr_err_sbe = ddr_in32(pdata,
 					    FSL_MC_ERR_SBE) & 0xff0000;
 
 		/* set threshold to 1 error per interrupt */
@@ -628,8 +624,9 @@ void fsl_mc_err_remove(struct platform_device *op)
 	}
 
 	ddr_out32(pdata, FSL_MC_ERR_DISABLE,
-		  orig_ddr_err_disable);
-	ddr_out32(pdata, FSL_MC_ERR_SBE, orig_ddr_err_sbe);
+		  pdata->orig_ddr_err_disable);
+	ddr_out32(pdata, FSL_MC_ERR_SBE, pdata->orig_ddr_err_sbe);
+
 
 	edac_mc_del_mc(&op->dev);
 	edac_mc_free(mci);
diff --git a/drivers/edac/fsl_ddr_edac.h b/drivers/edac/fsl_ddr_edac.h
index c0994a2a003c2..de66f9822fba1 100644
--- a/drivers/edac/fsl_ddr_edac.h
+++ b/drivers/edac/fsl_ddr_edac.h
@@ -70,6 +70,9 @@ struct fsl_mc_pdata {
 	int edac_idx;
 	void __iomem *mc_vbase;
 	int irq;
+	u32 orig_ddr_err_disable;
+	u32 orig_ddr_err_sbe;
+	bool little_endian;
 };
 int fsl_mc_err_probe(struct platform_device *op);
 void fsl_mc_err_remove(struct platform_device *op);

-- 
2.34.1


