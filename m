Return-Path: <linux-edac+bounces-2009-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAD699A7CC
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2024 17:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775202865A6
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2024 15:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2B71974F4;
	Fri, 11 Oct 2024 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i7hM8ayA"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2054.outbound.protection.outlook.com [40.107.103.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD4D1990D0;
	Fri, 11 Oct 2024 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660737; cv=fail; b=FOrAV1CqL4qvyfOtBABBvtVkJ19+PLY8+zAMdNFdF0mLrLiJA8Qesl1KkDByz0I1QUNmfVJUoFVGkTXRuNA01G2u82TWieMdH+CzcqUnSoaVWg20UUuXiQCpuwcuC5KKE+SKw1YC9pyNOB+yxJIM0ZrCQbVChxi6BuYiRwiLFuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660737; c=relaxed/simple;
	bh=lyWe/ySMkDZ490wGZqd1uDY524RbQ2uyh4spYd1a1x8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UW0xZ33tI/kXOl5uFRS8s1eHdRocz0bAmWyOZ8VfsRzQOnMU2g0dkMw7vLxx1Xl5uQibKmS2xAzfrtyy2v/KaDw8I4OhYcn5aYsHtoeqpfoAEvzFzdF6IzMB4f76N3r/qUWzDSKdm2b8uhSP2P4oMckBofzfCA67uE+8fn1uGfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i7hM8ayA; arc=fail smtp.client-ip=40.107.103.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGxKQfLwGyZREdw4HxRv4wrJ2iZm18NK+X3uwJIdL5cDFGKKWwuB4lOB6trIS/+AL/ak4drnMEqPg/BBVV7vtv6zzq723zVjU+41Va6qH26XT2DUUJZMenROAoLpRHDGk6FaRBlLoExhTLqWmnsxKIMD7zJ1q7IOpc+8VxppIuw9JsPuR8pdOL/COgJdmOQuAhq8nMdmjNypyYiEGv3FohXcFgCb4uygUAPAvwieJtiVpG4etAky4vL74IpCx9mvu4XLLnanut2KKyssPbC2GK/iBnPhVKJbUAaRLh9u6f+pTJ7c5XBqO/wfR9F695r10fEtpVVL00eUJW0roJPbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMo2ngT7gPC02/8eJPlx4Oq5Zz9LMuVnQAOCsuCJbzU=;
 b=NAD4mCozlbfl40y/GccvCefq9CSxXyu4Ulp6rMGucHpGa3Setx643tvnprH09Bw63mSMD82i3pCGDisTGIZMmIya9FZEZNA5r2JVhZ9c7nx+esalTCuJjxq1Hb9nSC3gr4+zkN2ktXdJZLL/OzpnBUJ9Ga0grynRqu7SqZs/39gUnwvgyi81LD6JY2oaq+cZ6XFC61a/hvhMEX6OEO24z4bYQi+zvcJlLumno1aoAVW1WU66N0cspaBcHTshUgQaWdwsngfYlx4mGl4qzojpzut1BDuOfyc0amsDUauywTxZfGjag5zxBl3Pb0CzTWXIXVDLdD+84CvDOABeAGvm0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMo2ngT7gPC02/8eJPlx4Oq5Zz9LMuVnQAOCsuCJbzU=;
 b=i7hM8ayAI0mDQCWGuR2nvsP8Z+kKvamnuB7HoxGyy+DMCqvrpDh4RendBFLwaM3BFAi6ra4sE41lwwZBaV46IZEhUomEFsmw6/Aw1oiU4xU8QOiETb2yB9oA7sdcDMi1TiGHl/SNar4L5G2Dx1D2FL0m/+LPtKjniQiCKUnvglONPqRttwpuGB1WuRyhZjbA4QhpTK8hduCU825LBIu8Mso6V5Z8+ivg4+tymHO9lSDPPQItsEhjg6l2jthCHSGEl3IjXgHopb4GUCFkaaht+3P/a+LauaCpFq4Uas2+cd4Sigzf+h4TIgfY2DJaY2bAPisAPuaBSsYNF01JrF7t3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7360.eurprd04.prod.outlook.com (2603:10a6:800:1a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Fri, 11 Oct
 2024 15:32:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 15:32:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 11 Oct 2024 11:31:32 -0400
Subject: [PATCH v2 4/6] dt-bindings: memory: fsl: Add compatible string
 nxp,imx9-memory-controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-imx95_edac-v2-4-011b68290951@nxp.com>
References: <20241011-imx95_edac-v2-0-011b68290951@nxp.com>
In-Reply-To: <20241011-imx95_edac-v2-0-011b68290951@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728660703; l=1970;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lyWe/ySMkDZ490wGZqd1uDY524RbQ2uyh4spYd1a1x8=;
 b=8xslh7HyUKmks2Olrk03Ae8GT5TqK/INwuDUBhtlDDIKksmu24kLZyPT7edpKvnbT/Be06O3Z
 Y4s6zNk2GrFAcsi7vbKkJBbrYW+H64BVD7o25CZGmtRRLxDfSq2Sr6N
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:217::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d46f4a2-257b-47c8-3d54-08dcea09dfc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUVVZ0FFdVJlVHF5Qm9TSy81RGNkNUpyUzhMbjE4RklKNVlzZi91ZWlBNkFN?=
 =?utf-8?B?SVpINUdRSElKMWxTWVdxK1czbkVQbUU0TGN2SmYzcEpOZ1NpaUQrT0NneVlD?=
 =?utf-8?B?YkdkOEhjMUFjdlgyZjlURE1DeXNRUHd1WW9ZVjBVQzdFbUg3MHlnREtKbXo1?=
 =?utf-8?B?azRWQlo5T3NTZC8xZmlnM0JXU2FZTjVNVXgvSG5pWmMvNDAwSmROZjFESW9O?=
 =?utf-8?B?M0NRKzFPR2FuQ3pZWTF6ak9vd1lLbmp6cXZ6cUhSZXRIT09CY3UxSEw0aDFG?=
 =?utf-8?B?bXU2Qlk0OXFlWWF2OGRmMXZYaVJsNVlPQUN5Lzl1UGw3bVNHNDRPZ2tVQ1Fz?=
 =?utf-8?B?d1JydEFmeVhkZW5mNXNOT2NLcHNMTGNXL3lqTWk4V0RGYXdEaHh6Z0lQZmt4?=
 =?utf-8?B?Y3lkdmkzdmpPaFphaUF3RGpid2FxZTNsMUpwVmd4QVBHTFRaZTArdTJVSzBn?=
 =?utf-8?B?Ym5IajFZbHN6SkZqVFhoSVgwVzlSOXBkQWI0amFkMjZ5a0xHcVFTTTk4NEUz?=
 =?utf-8?B?YjRkVGI2YUR3M2dFOGN5eGlEcTVPeVo5R0hIazFYamxhUWNRSmpPSkhFMC9k?=
 =?utf-8?B?cjkxbHJ1WVhqZWx3dmZmd01MeElIQU9qVU9TbXRuUlJGVFZGYVNIVDluTjkw?=
 =?utf-8?B?eFZXeFU3RUVrUkZRWmRvWXhNcitXbllndGdpeVB3eitEdTl1KzFtdlZ3UlJn?=
 =?utf-8?B?Q0gvL0V3TWlCZDBoV3ZhTjVOelVzSlF3VmQ0elY4b2hucHdWUzZ3TllwUnVH?=
 =?utf-8?B?UUdOemRzVTZUUGV1bmUrdHJjVy91OEhUNjMzdStBcDVUUmtYand1SElyWTZE?=
 =?utf-8?B?UkJpZEQ4ZTNYdWJDOGZISnpiTzhWeFhDYitRQlFxRTlvRXZiY0JGZlZ5VVZM?=
 =?utf-8?B?RXViNUE5MDU3WG5QQU1kUWdwZi9tMm9ldmZxTjhRNnVvY3JLcVNSQTBRdFp4?=
 =?utf-8?B?UzNvdURydFQybXdTNlJLdkZHcVo5b0tJTHhUMTJvRlhnSWdWM251NGVDR1V3?=
 =?utf-8?B?QTBMOWNRZFdhdkh4Q21ZcmlyakE1TzQvdFVKbVlCRk45MlhvVmJUcWNYdGkz?=
 =?utf-8?B?YTFxNit2ZXlMUm9QQzVWTURKQnZHa3JJMjBwYTJGMndUV21mRDFwUHJqOWJY?=
 =?utf-8?B?VlVZQkJrWkEyL0VpRllPY0p2TWx2ajdTYitFdkZpWmc2eGcvZkdiS2dsdEJC?=
 =?utf-8?B?VDNXMmRPbmoxTXkxaFZDUU9IMjI2VkcrNzVzV2J1QlhKa2hYa0tWdFZDNXg1?=
 =?utf-8?B?akdHeVlJeGJHYnBtd2UxUUtaaFZoenExdm8rWHNMMklNbEIrL0w2RFRuNWhq?=
 =?utf-8?B?YVdLcUdCNy9veXh0ZVRhMXFTQ2RSaEhRYmg3aTNoaUlmZG9mU3pFb3BTWnp4?=
 =?utf-8?B?YUh3dnM5KzNsTmVhMmVTT25mcTA4MVNOYmdGUGtTOXRoaUZuUWVVWjRwL3ly?=
 =?utf-8?B?a2cwSmdjVXRYZTNwYXNnQTVCRDAvcUIrWkZRZDRZdE9hN3NuRGtHaFI2aSs0?=
 =?utf-8?B?ekEwWXpsMXZRcGMyd3RDeXIvNm04UHdrYkJnckYrUEN1dnhHS3RVSlpDY3ZY?=
 =?utf-8?B?eEtDRzNXRDVHc1ZrWGt2aFJtUVY1bktVNWdVTHloeU5KMDNQK0FGWnExQ1BH?=
 =?utf-8?B?VklaNXhBOVZBbnlZYTdpc0FSUHpOZ2U3Wm9xYzV1K01Oc0JoS0lzR0RVUmxI?=
 =?utf-8?B?c1I1YXpFQUN5N2pLQVZONmUxY1JGVHFMVUh2SklsYjkzZm13VjJrdXhnSzZa?=
 =?utf-8?B?YU9WZWNPM1UvQko1bzBpOHNJL0NITXRUMzdHcmdQeGJOb2xFQTJiSVVuTk1k?=
 =?utf-8?B?YjdJWE1hZ05NOE1paG5iUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE5pMGhGaVJualdKZjAxYkJWNGxsdSt5Z1R1Ly9Td2FSSE5TbnN5bmlZaEc3?=
 =?utf-8?B?clI0bXpGdTZxRWFxOHNuZFNweWErTkhuSk9uMjRMYTZ6VHJmTXBiZTBKblRK?=
 =?utf-8?B?ano1NXRXNjc3U250MStyMnhIU1B3ZGF0L2tiZFhaSXB4bklqQTNKeEw0bVZ0?=
 =?utf-8?B?dThTbVh0TnNiNDRNRGdYWkdyZ2dCQWN4ZGVUSGhtOC9QYWg4bXhuUTArcWFl?=
 =?utf-8?B?NXZTSWN0cFhqSVBQM1ZIVi9QalFjWXFRVkptaVRBaTAvT3hsR2t0Wnc1WFg5?=
 =?utf-8?B?QlNHNk1TUHNyeE1OK0ZyOFVXU3lQaHV6R3dCZ0RqYkdTNXZYN3FaY1VrakVo?=
 =?utf-8?B?RWRTSG1DSmZJRFBVVzBTSzZCSmFrSFRrSWUybHNqb1BMMThYdmFWbURtYXhh?=
 =?utf-8?B?aGlTb2Q2aVZQbDlHWXRZdWFPYXdIbDFmazNCcEl6c3ZyNHRsS3crdDNKSDgw?=
 =?utf-8?B?c2MxWHNPZE9hQ0RTejM0dHBIcHAxT2NpK0hxKzBZUHVFMUNvZ0JMeFNwWWc0?=
 =?utf-8?B?M25IR3VFZ2sycCttdkljSmtTWVlSNkx1TFpoT1UyY2F3dWRlc0JrL283dFlS?=
 =?utf-8?B?TjhPckZleGIvbHlmbHFqLzFQaWNveUFBK0FoQVkrQis5Y1hpLzR4ak5JMXBS?=
 =?utf-8?B?NnZJSDZiWnVZWFpGUlpiZHptc0dZekp2TTZ1WXVaTTVyUy9vOUcxWXM4bGpD?=
 =?utf-8?B?Y2Q3ZUZrWjhSc1NweDVFOXNwUDVQeTZKelk1ZGp1TkZKWjRvYkV6ZWlFNVgv?=
 =?utf-8?B?RDhka0JzMURtNjJ3M3p4ZnUxZ2lnb3lMeG0rWnNMbzRvdVhVVkhUSHArQXp3?=
 =?utf-8?B?b2w4aXFpZkc1SVZLOVZ4QU5qZGhoMHJ2MVZjQVV3LzEycFNwOWVYOHJOaEJZ?=
 =?utf-8?B?ZFBkTitvN3V0N3lnY0dnRjY5Z1BUdTVZNFNBSGFBVmQ2VVFxVXhheTRPYmhr?=
 =?utf-8?B?ZDVtZ1dxdXlTMUFSbStUOHZoT0lEeUU5TkN3SUVpRFdvNlA2NmZuSmVJeHdO?=
 =?utf-8?B?UktFck42K3lHaVZnMWc0RzlNVkRwakQrMUVJUi9IY1QvZEltUjZ6T3RMVGhP?=
 =?utf-8?B?UkNIUmVJWVI4V0d6bWY5OW5NcGVXNmxTRDlDeUF0RzZyeTlaU2xHUENMeWx5?=
 =?utf-8?B?L3d6Zk80WWtkR09mQ0JqQTYzbGFScXY5a0l3U09QTWhYOTZrVE9VVTI5TkVv?=
 =?utf-8?B?WkJrTlovbGZpVExSR1FOeTZjYURRSGNOT3NtTXUvQUhwOWVhNjJvQTdxdVNp?=
 =?utf-8?B?clVUS2xndlF5U1hLWHpDRHl0aUlPS05DVDRmUUFWYjhLU0V0dEg3SURZUHBL?=
 =?utf-8?B?ODMyU2FkNy8rbFdHZGhKTllRd1ZHcHBPVTFQNDU3YmNSK3lNRzU0UC9GL2pQ?=
 =?utf-8?B?MHk1cHdMMjBaQUQyNTlFcjhIVm5VYjdJVXZYWEJ6clRZaXJHaXZWcXVKMzBZ?=
 =?utf-8?B?d1R6TVlXb2srbnlBQzZJbm5GWGZQS1B6aTNiTFdldG9vMXJJanBzQUtrNFds?=
 =?utf-8?B?NEtweVpscWQ1aHMxQTlubUlpL1ErSTF1SXR6bm51bXNOWHNUSUFUMXkrQWZG?=
 =?utf-8?B?NGozV1dpL1JpeUVVbWVqdHk0Zy9PbWZ4TUt2TlZKczVCNjYxdUhITWZ3K29Y?=
 =?utf-8?B?Qi9sVjNLL0Q1ZmxIL0dpSnluMEdIcm52SXR0TG1zV2doTnJFcHQvWGxMVmRH?=
 =?utf-8?B?YlcrYkxDcXdnY25PNGRsSDdkdXJpMUZvQ2VjaWMyRThxVkZuK3ovOTRNUEJa?=
 =?utf-8?B?dFVWSG5INjBqWGxSOVp5UkZWblpIbmNXUisxRjFYNFU3T3IvMDNvcnArSCtp?=
 =?utf-8?B?Q2Y2cmlVQ0lWZTRPNFpVZFd1M0pUcnN2eU96Q1g0dkdZYS8vVU55ei9MTzhJ?=
 =?utf-8?B?ZE5ibk5ObUtLSTkzQ01oUktOejdMdDNhY24xR1FoUzRHVXBuTnFiWUFxNFM1?=
 =?utf-8?B?OUJyMTMwanlZaXBacldKYS9JTHYzaTdqM2VDQXcvckt0ejFGbnlXU3NMWE1L?=
 =?utf-8?B?bTd4Qm5FQXgveitiY09TbUUxcXhHMzc4b0pJNzF1Z2VaRzlEeVVUaHFUWHUv?=
 =?utf-8?B?WGc0Y1oyTEl3d0JEK3B1cE1FS3dnc05XTjJQTzZXUnpEd3N5Vm45TEF2alZG?=
 =?utf-8?Q?fiQ96sKIaAM0G1p1EvjabuojU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d46f4a2-257b-47c8-3d54-08dcea09dfc6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 15:32:11.0828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAzlLe0S7kgcgZsVFsmqVLzX02+BJ7gHLOo7jRqF7Oy4zOWWD5Mb7GKeZfsQxtGFNRZvJ5MI1B9tiyf4iSoxKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7360

iMX9 memory controller is similar with other layerscape chips. But some
register layout has a little bit difference, so add new compatible string
'nxp,imx9-memory-controller' for it.

imx9 need two 'reg', one for DDR controller and the other is ECC inject
engine register space. Keep the same restriction for other compatible
string.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/memory-controllers/fsl/fsl,ddr.yaml   | 31 +++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ddr.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ddr.yaml
index 84f778a99546b..e0786153eec73 100644
--- a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ddr.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ddr.yaml
@@ -40,6 +40,7 @@ properties:
           - fsl,p1021-memory-controller
           - fsl,p2020-memory-controller
           - fsl,qoriq-memory-controller
+          - nxp,imx9-memory-controller
 
   interrupts:
     maxItems: 1
@@ -51,13 +52,41 @@ properties:
     type: boolean
 
   reg:
-    maxItems: 1
+    items:
+      - description: Controller register space
+      - description: Inject register space
+    minItems: 1
+
+  reg-names:
+    items:
+      - const: ctrl
+      - const: inject
+    minItems: 1
 
 required:
   - compatible
   - interrupts
   - reg
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nxp,imx9-memory-controller
+    then:
+      properties:
+        reg:
+          minItems: 2
+        reg-names:
+          minItems: 2
+    else:
+      properties:
+        reg:
+          maxItems: 1
+        reg-names: false
+
 additionalProperties: false
 
 examples:

-- 
2.34.1


