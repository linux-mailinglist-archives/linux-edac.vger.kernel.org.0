Return-Path: <linux-edac+bounces-2112-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EB99A1401
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 22:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869CF1F22C9F
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 20:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D9A2170D5;
	Wed, 16 Oct 2024 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M41b0SIk"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A801C4A14;
	Wed, 16 Oct 2024 20:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110704; cv=fail; b=gkdRjYMLL+Uj0IK5RJ4e2hnhLNN1xkWADR4iBCi7/rO9gVymwzIoutddEwPpXo0DUk9HlFnFy+Y7mIMLtY/3bXquDYWmrHIofoff9w5fM6QDW38KutAsOPPjVu44ncZ7nQEqVzgbD5HA0M8ZMVd8J23UebE/XiFik19kZ6JIrDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110704; c=relaxed/simple;
	bh=bYOSUeH8Tsfygywx3VBHrQIC4eU9dzx5J8svyPSfkS4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PBiPC/yfm83fUxJeL2hDNQgyOwJuLXRDE1n0h1wPc3FOJVYJFiPETHAp+SBhNdsADKk1OnpPZhEh72XZ3HpcMIPp+eaefoD7lD7rCbhIKMzKOHExq4TImuytXuMYRh3I5UxM5/hl2D2ViXS4w0A/OOcEKy+hPAS4upHW3fHFkn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M41b0SIk; arc=fail smtp.client-ip=40.107.21.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNzKmygUhsp8gm9gI4tEUignAIuXPEThaOPO+iAo3Jdcjrhi3Eshn1kvwrgryBuuZMCwLzJOQU7ViCptRq95NYMHRyF8J02JG8c+bHTPB01+UfI8hzO8Q+WbeVCl0xdbkGnkDej9bAikbChhpqWxz9ekXEWZ3H7SMJoTHRZ5zwCxlC4etjLAK+SZ4AWX4CtghHqbDY+QF9X3yms6GPHEBFmtZXPNTa5gUjhCFoEsmc0WeooVDVlfOyS0mUlobwBt8z2u+ptkZ4Q5cXA+UTN9P8KnAfp5ss+yt3DyHS2HFFxT2kdOcjVWCrRtgb01oa7zTpixshDW2nlcCEVObXY74A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oThGc+PInWWFzFHWkQtWRVZUx01s9iDEryoUEl8TSD8=;
 b=npss4q7HddpLqjpOKOIn4T6eAsqumBA6eE5wwNc03HPRti1qruBUl/wpj3HIyfyWIMrqtXxWg+8ZES38kM2yD1eGoDoYQY47U/J4hefjB8Hj1aUTKkxD4/U30ecAmvm5Q6WQfWoPq65u6LaZjBmMVTHOMQGf/r3u5LH3Vj5wtjWJtJv18OHRVM17NTJdnMfTq57nbrx3gfTmCSGh9rWtPuG/3yD+q10LBCNgXAjQbFaCP4BxZWTNtiMJEHG8h3diWUbTqHAonix5c4hsboD2twITVyokF7HEwGV3JjEYiMdYoJhfCGrLD2mRVqg7BhKdUBvTeuU8er0SKfgK10nBbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oThGc+PInWWFzFHWkQtWRVZUx01s9iDEryoUEl8TSD8=;
 b=M41b0SIkwItn3SpnFblrgb2c3amjjvao121fzz9DCPW5HIQmU8nz6cPH+T2dG+Jd7YGcE9x4Fvjgkt/Ru+i08uxlyHVexUZU7MHJoflyd+D2MhIXWrk524aT3r7CkxRMxLookDUo0YqKq4SBvABuuH65UK7/InVIDpsulyplhIPDscHI1vlrao830GBLPSLZMCLSxoooMFejfOIYc4WRYzbDYY1VWRCr9NeNqeUNLNq9kQ28srG91CxehHc6KrRvQcdJ+Jj2Ee2KzOKsfhOFAben+ylIEc27WmJkC1IGhjXH1ZT0yBIvhIZoidGlzv0MMAFX7dOytKncUP6YRMk2aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9845.eurprd04.prod.outlook.com (2603:10a6:10:4d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 20:31:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 20:31:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 16 Oct 2024 16:31:10 -0400
Subject: [PATCH v3 2/6] EDAC/fsl_ddr: Move global variables into struct
 fsl_mc_pdata
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx95_edac-v3-2-86ae6fc2756a@nxp.com>
References: <20241016-imx95_edac-v3-0-86ae6fc2756a@nxp.com>
In-Reply-To: <20241016-imx95_edac-v3-0-86ae6fc2756a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729110683; l=3246;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=bYOSUeH8Tsfygywx3VBHrQIC4eU9dzx5J8svyPSfkS4=;
 b=EKJ8Dge2Ozee1A5eHctxPf+S/Ui6RqoLC6ohUz06aDXLz0UD0HtMz1CDFZWmF1+QiLVF6XjTL
 6FqZaRM0buaDpWWjPtzLsbT0bxa1pUWy+WpA1RnLq6V0AOPwE0LDTxU
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0042.namprd07.prod.outlook.com
 (2603:10b6:a03:60::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DUZPR04MB9845:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9e725f-234e-4f9e-14b4-08dcee2189f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWVSMWlTL0J2aFMrQkxRVy9ab3MxbVZuQVdwWEVxSlU0VEFvcG1TSTlCZ2Jy?=
 =?utf-8?B?KzRENkRwaU1taFY0K0FUSWlxc0NhV0cwVFgzeGJhUWhGS3lPbUR3Q2FVd21u?=
 =?utf-8?B?U1Z6dUVNdEhoekhYWmp3VmdJeTBqVVo0RlJkRGZ4UzluMzNLOXlMcnFXRlE4?=
 =?utf-8?B?SXB5Q2VxQlZMZHF5WjZUdVFIYTY1eDJWcllWZUhJYjJsZGJyOXZYOFNYTXdU?=
 =?utf-8?B?RUpFM0pIOGd2LzBGdlVKaStGQkoya0lnTG1Md0UzTGlyQ1U1UlRyOUQxZk1x?=
 =?utf-8?B?VEFBKzM3QSt6c05sZmlQVTlUeENuQmNMOGF1TkZkR1krbWl1aFkrcUJSWk5P?=
 =?utf-8?B?RTdpcldUaHVXNFBSLzNXOTBURVVoTGZNdW8xcmR0SXY2cU1wNFBiaEN2bHZp?=
 =?utf-8?B?Zk85UzhtRVd6SVZmN1N5aFlOaEpSbU9VTWhXQTd4NXgxL09FbEI1a0M2WTRW?=
 =?utf-8?B?Y0s5Q05WY0haQ25DVU85UE5jTmRNdWg1eER0WlV6N2xlZm9OU1BUK2w5cm5u?=
 =?utf-8?B?Y3VUa1hLaktRV3dGY0t4YWYyekl6dzJhdG5sd01LY04rTlVsTkNuWkhCS2FJ?=
 =?utf-8?B?eU5leUVXQkZaREQzbWxFaXlPOXZjYkFhQ2VlNkVSd1h1bkxaV0lHd3c1bHJj?=
 =?utf-8?B?VnU4RHl3SnNJWVlDUzJtL3N2VjhyV01MTGxBWGtITWI3cWk4a1NIU3pnZjNC?=
 =?utf-8?B?bU15S3hUMW1rM01qcFJrRFRSZHkwUnFQb2Y2d2Q0VW5OcDNFY0d4SmlYTkdT?=
 =?utf-8?B?dmhiaERxR01ubzRzNlIzOHd4VG8vbXZBUE9SbWQ5QUlSNmRLUStoZ0QwTEVZ?=
 =?utf-8?B?YjhrdmwzTkYrSlNtZEY1N1I5NytSVzE0bDFJSWZLQTgyVkF6d0ZYQytQeGZj?=
 =?utf-8?B?UkhZNWJtUk0wbHBldGNKL2JsSmRsTi9iL3hqSmJxRk1BRVBRa0xBSjJyOVFh?=
 =?utf-8?B?UU1qWmJSekZnWFY1T0lJTWdTNlE3RHFvc0swTG11QnNldFBLUXV5WlBydUxa?=
 =?utf-8?B?QXJzRlppYVB0Q09CMHgvSVRIWGRHSFVXdm13S2RWWTBKbTNnajdxcTJWa0pY?=
 =?utf-8?B?eEZtcFJUcXdidVVLWTFaWitmTTd1aldUdEJQbVFKWXNwUmwrYkxxTFFOSDhW?=
 =?utf-8?B?VkR0UjYyYmdKWnBudnBtNEtWZDRFbjBqcG1vM1ZEcFBURHZiYXpiSktyN05o?=
 =?utf-8?B?S1AwTk9RQmRFdElYRHhmY09ZeVd4V0NCNHVZaEFxWkJ5Rzk2UCtmNU81L3ox?=
 =?utf-8?B?czh4cFFDdEdOYVNuSXdaTnJJSkR5SGttU1FOYkgvdjFBTjlzMldLd2hPL2gy?=
 =?utf-8?B?c2pBb3hEdHUzM0ZrQi9QQ0xBUXIxRkE0UE5mRWk5RzVPSnUyRGcrNis2RUxY?=
 =?utf-8?B?TUFmZDdSWU83aVgwQndVNkhnRXVQdHQyN0l6bW9uZEprTzJ4Y3NLN2dPVlgz?=
 =?utf-8?B?T1dEVEg2d1phWFdqdEdrTTdrcExaWElsVnhjQ2JLMk1DY085Ym9YaldGNk1m?=
 =?utf-8?B?VkFQd1VOSHZKZnJKcHhrUUJOZHUxaTZlOUxZK3RPazBkcjIzaUl5bS9WNDNr?=
 =?utf-8?B?ZkR5Z01aZmtEeklndjRhYlVDWi9wVFNLUkpzRXVmOC9oanZkVXpsaC9xc2l5?=
 =?utf-8?B?MjgxVGlwWnhCODJRV1kvbWtuSDJVZ3NnL1hiMnl1UTZKckx3UGdsbW93a2Yy?=
 =?utf-8?B?QjhGTTFUMmFRM3Rvb2hSV3E1ZzhBWFpzWmdYcXFxby9Hb0xGdDg5cTJQQ2xl?=
 =?utf-8?B?VGJJbnBHcFFhUmJLUEhTWkRLY0MvQkEyREFsZkIrNFlnbzVOdEZ6V09veXNs?=
 =?utf-8?B?M3ZHZWphSnNyVndKU0lPcW1Ga1Y2RHhvektsbUVpemJhMjJPa2RXcUNIRzBY?=
 =?utf-8?Q?CIRBxvauV7YE9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHBkK2JaN0JPcnZZQ2VCZ1NmemRtT2ZEckQ3ejRhMXJCc1JMUnBvSENYVWVy?=
 =?utf-8?B?dGdVMncybkhQMnV0VTkxYm14aHVCK0xTZnN6bGszRXhvOE1udTlTQnlCRnE2?=
 =?utf-8?B?T3lwZzZKSHJxWi9Ub1l1MnBrL2RkckRTWkpKbmRjdnF5NnU5emsyK05GU3Ju?=
 =?utf-8?B?NUpBQnVyUE1nZHRsV0xORkpkTWFicWxZaGQ3QXNRT2Ryem90M2tHRHE5VlJW?=
 =?utf-8?B?MGdNM1ZwUGg5RENEZEEzS3hPbi84RkEzWXQwY1JUamg0a2MvVG9rbXptcU1T?=
 =?utf-8?B?Lys1cUN2d3JxYUROMVFhU0RxY2RnT011Z2JTbWU1RkcrQStLV2tMTXJtLzYz?=
 =?utf-8?B?dHlnZzdHYW9ieXd6bGp1NFpGWDZyM2tGSXBRUmkyZGRQZFcrLzFxVllWV2tj?=
 =?utf-8?B?TTRTK09ZUDNKcFFMbzRpQ08wWXFzSFBETUt2cUk0VzBlSWx5dGtIMEhRWkk1?=
 =?utf-8?B?ZTB3UGptUENQb1NrekpUWkE5Tlk5bEtWWHk1N1lZN3o5ODFWdGVpa2FxRm1u?=
 =?utf-8?B?SndpU1dtT1p1VUc0UnRaYWVuMHl3RlRPLzJJajlCMDVZWGdGdGg2ZlZtQ085?=
 =?utf-8?B?dzVLOUUydXJDS3BLOVMvcGg1Z2IzOWVTNDZQUVhWKzVpQWFGbHlxV1ZwZk5q?=
 =?utf-8?B?Wmo2SWZxRHMvWWlyV2Jlc3UwMklkc3picjUzS1BmcExidkpsZk5TMGxnSVdz?=
 =?utf-8?B?a3RER29BNnFieVdnNnJtdHFtTzgzK1ZWOStIQ2dsSGN0NVBITDIxbHVNeWU4?=
 =?utf-8?B?MFpCcC9SbHdZdURDSE54ckVnQXNQZjNLZXRFQmVXT044VlFnOUhpdGF1Tmwz?=
 =?utf-8?B?SVNEY0dkRlFROWJEbXhvTnUvbmtvbGwzMUY1YnAya1hsWWdxcGk1T3BRdWNV?=
 =?utf-8?B?MDZGL0hGTnJ5NUxGYjdyZjJQc0FlNTQ5d29IcHRlcVZCaHdHY2UxQnFSSGlk?=
 =?utf-8?B?dEREZ0tHU0xya2RSTW10UytoK0diZUtYWCtScEZVdmhaVVFmaFZ0RUlnYy9a?=
 =?utf-8?B?ZjU3UWxLeVRYNFpDTmNxa2t5UG12Z1F4eXZETk9MTHlLS1VaOHpOb1VYUTlw?=
 =?utf-8?B?U0tGNnZuOFRYMUtrc21INkdpQ1RWUERaSGVLNm8zNjh2SVpzZ0d3akF4MERp?=
 =?utf-8?B?Ny85TExPWDdZcjhoODNyU2xoM2VPTDZrZVorSnF3bUVzUjBmdHdaREVKYm1q?=
 =?utf-8?B?ckJDQ0gwcDgyUFZ0VVd5UzhnejB3Wm1HWnFsSXg0V2VEM21jL2VYUFN6R3FH?=
 =?utf-8?B?Ulh0UmhxWEgyR1NFYkZjNDFwY1dLcEhEcEZLZTY0Nmo4a3FSdGVNbjBpYVNw?=
 =?utf-8?B?TzZrSGJRRlVJL3F1RkFhRkpFRkt6VTd0UVBVWXdZdDMyL01QS00xbjZYM3RZ?=
 =?utf-8?B?dUpJWXg1bkpZRGxIck44eGpHZDI2MFdmSFhtaXRKRUo1VDlSZnhmNnFmUkQw?=
 =?utf-8?B?QVR1a2pYckpvMXVMdDVwZi80cEJJNUovelZrelA4eDZiNHFENGJET3BQVkVt?=
 =?utf-8?B?aGdWZzVhTHRBZXZadFJrSGU5QVN4bzI4TWdmcEg4Nm5vUGk1LzRxZ2s3QXBI?=
 =?utf-8?B?ckUvOTZqbzhPZEF4QnQ1OGVkK3UvOTJRN0tieUZET1JpNEYreFZZMEJEN2Vs?=
 =?utf-8?B?d3lTSElrNEZ1dEJiVjVrV1pZZXhnMDRQNHdzdXkra0kvaW84YXMzOXV2YXJJ?=
 =?utf-8?B?MW5RR0lVQTlDdHNxT3gvS21MTkpVYjhIeUNhcGJQZ2pIYXZacVhDeXhBMjBo?=
 =?utf-8?B?Q1Nta0dzbkNaTE0vaVlYeUxrbE5PT1o3bDJtb3VuT0RBbk1JTEFxeWcyYnRC?=
 =?utf-8?B?YmMxZW9OYS9sQkdwcDYwcFA5MFpMQjZPSzJGT2duTDFtaVdTbkZ5UzBZRGs1?=
 =?utf-8?B?Z2JTcVJRU2Q3WlZ2MlFFWkx6QUxKZEVUZEtoUTdRSmVtM1kvcGZoK25SazJo?=
 =?utf-8?B?ODNjMFNCV3VvNWd4MGtpM0lhVmJTOVlVeUYxQ3g4WEtuSGlaWkFUN3d5MVBG?=
 =?utf-8?B?N1ZCMXZoc3hSSVFNeUhXTE56b2FlZCs3RlRVbndCbUMxQUM1NHl0cmpqN284?=
 =?utf-8?B?SUxrcWFUVlJxVTRxWnI1WTdMdWc5UU84b0t4b2RqV2Y3RFp6aURKYTN6UmhI?=
 =?utf-8?Q?lHr7/rCdNXf3T++M8r8hnyuzn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9e725f-234e-4f9e-14b4-08dcee2189f3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 20:31:39.6367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYPE268wOfISqh9pNv4rPJNh4MXRFgWaut2MenZqSuNVd2P/8LlAmnIOQ/N0CgtChJP768cYT0+apyoG/r+4WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9845

Move global variables into the struct `fsl_mc_pdata` to handle systems with
multiple DDR controllers.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
- rework commit message.
---
 drivers/edac/fsl_ddr_edac.c | 21 +++++++++------------
 drivers/edac/fsl_ddr_edac.h |  3 +++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index 9924c6b816648..7a9fb1202f1a0 100644
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
@@ -562,7 +558,7 @@ int fsl_mc_err_probe(struct platform_device *op)
 	fsl_ddr_init_csrows(mci);
 
 	/* store the original error disable bits */
-	orig_ddr_err_disable = ddr_in32(pdata, FSL_MC_ERR_DISABLE);
+	pdata->orig_ddr_err_disable = ddr_in32(pdata, FSL_MC_ERR_DISABLE);
 	ddr_out32(pdata, FSL_MC_ERR_DISABLE, 0);
 
 	/* clear all error bits */
@@ -579,8 +575,8 @@ int fsl_mc_err_probe(struct platform_device *op)
 			  DDR_EIE_MBEE | DDR_EIE_SBEE);
 
 		/* store the original error management threshold */
-		orig_ddr_err_sbe = ddr_in32(pdata,
-					    FSL_MC_ERR_SBE) & 0xff0000;
+		pdata->orig_ddr_err_sbe = ddr_in32(pdata,
+						   FSL_MC_ERR_SBE) & 0xff0000;
 
 		/* set threshold to 1 error per interrupt */
 		ddr_out32(pdata, FSL_MC_ERR_SBE, 0x10000);
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


