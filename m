Return-Path: <linux-edac+bounces-2008-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B8A99A7CA
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2024 17:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05B65B243C2
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2024 15:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FC6198E63;
	Fri, 11 Oct 2024 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G0P0puEG"
X-Original-To: linux-edac@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41D3198A0E;
	Fri, 11 Oct 2024 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660730; cv=fail; b=GdOIZhWeF87lgEZ8kqnY1NkpM2l4SJl09yipREDyQ5XNRZlBbbZ5pL79jGXrVI00OESsmgVB4lnNICWoI0oTWRvNHKxGwCzLiELvnfhM8Gcwu8RqdD+uFKHtDKZ6oTvlywjGSEwi8vuMJkv5qF3AiWWEEgJbqXXTcnV9Z5JMZ0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660730; c=relaxed/simple;
	bh=hC0sBAxHzPnh9khLdTN4tfAoX1ZN08Fnf4NleRupY5U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Ah3xYNFU+oxGBV7rz6FiSav33Nipt/2R9w6mCyVtcLE1u/FbuNuJ+xd8RpfKmVCR5buM+iDnav8RiGTT2TDxGAcHwUSTbK8b8yyOqn2yvea0SWK97DkmWUj8S59qt6U47r9Wbuim3mYFLt/yAO2BA6m2K3KbG/RSN+735wyenNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G0P0puEG; arc=fail smtp.client-ip=40.107.104.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLsMksbZ7ldFthLQgSBiinu453UTWNWDNGfUfR3GUuEOJ0BgpNJvnr5fTWskiQUjQYtIuVAU4D006lFQwn3S1fcvReitIyXR0AbyNTmlAJK+iYIJcKoB+TQ9QZj2ujzAuqUTBXNb/lanwRf2eXx65h1nXyynv1cbWICdLM/+KBhPbUe7pW5UaSFMNWtCnEpkF467H8EYhoduUiTMQdQwYsfalaI5CPGRQpPYZ7DypkFD5LqJ/b8J1gfVWX43Cq98cLYmGywcru900yLDLzxXRAXfCzjC0XXBWxI4bAm3DC8+JzckluR/uX8q1xd2wsSnwyvFduceMaVnqjrYqFhZdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1ERM/8wrAcld2CBubSctUu43sT3fAk/B7hSFIIETS4=;
 b=o+f/cSgD11bMsD8XzB/IXsuWxGldJZnt9zj/2fQkKW2uWj0mWBd/97DSrlcWzdTYSL1xE8Hy0PgI562ceKdoYP/4tTLCrAEFAjZlvFX5flCOLLl5AfoDXGgZUFXLqCQjn+Iv59RVwwBOhjP6jOCACMss+y8XDjFLRmxyrC6BdtcjpSpsHHfIdeSDStMQ1Ht3C9kzHtIRyevW01e9YRmw4yLebvchPtvBxrKDe2mRF00+Q8JEMIawtcLbK2ohmrA89euFvwvG4m1yjfkUBHWVcTicuBXGB+7VUTrB1FsS6LOpbpFMcavKoyCdJuoZD1N55H7xuhkfs2Q7OmTFdXXunw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1ERM/8wrAcld2CBubSctUu43sT3fAk/B7hSFIIETS4=;
 b=G0P0puEGzrIe3TKl0oNVtsIBYB3BnJYZzuVpU5MGDO23AR+U8qMvHrsRFGjGs2KGI0U8RfIrlzj20JSho4lRSiUAfyJr+Y+8aGW9jtGC5LluFrrinHGwG0myFMGFNdrPLPvbSTjE3aZxulwxgAghu12OCSfNW2nepdECOz5L2mnASwuaYy5YKKVlIPzLn9Yq2aBf2GSH2466pVNKIWp+mZze+cnF4xxQC5VMU5NSjfn0RsdSYY7+I5JSwHJUwumfr+mu6XU4OoB8IoAML+IzKE2aFPBYVlmV56BZa7TD7cLOHbasItb3kekYDHA0ea1m/T8nUVGprGdPxUsV3f7FnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7360.eurprd04.prod.outlook.com (2603:10a6:800:1a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Fri, 11 Oct
 2024 15:32:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 15:32:06 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 11 Oct 2024 11:31:31 -0400
Subject: [PATCH v2 3/6] EDAC/fsl_ddr: Fix bad bit shift operations
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-imx95_edac-v2-3-011b68290951@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Priyanka Singh <priyanka.singh@nxp.com>, 
 Sherry Sun <sherry.sun@nxp.com>, Li Yang <leoyang.li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728660703; l=1906;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+xRnp+RgtbOKGy8sOPUGCuuHfdPE/AGGQkiNocVxHng=;
 b=SMO52SX0EcGfPBqBbXpSDQbbPJX77GVtYwAMuCSnjLrGcDJ/ZFR56hKvD8MaU9TYgbn5zZv6X
 SFvzBe7b28uClXDQP20eGC60xpABjgiLBoGg2PWiMggsbsRFik+ii9U
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
X-MS-Office365-Filtering-Correlation-Id: 81e99a82-bff9-4492-ba7d-08dcea09dcbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3l5Q0hrYUpVWEMxZlRyZ05OMUV2TGtKN2lpbGg2Zk9BR2tJcFlwLy8wSDV1?=
 =?utf-8?B?Z24vdmRBbFlvU0IyRGVjS1FMTTRqb1pHNkgyOHhGUzB3YUQvQldMTUJqQjB4?=
 =?utf-8?B?SFhOeGtMUlM4Qmh3TUJPeTJydDl0UnlyZUN6MkJydGJQbWsrK3N4Wm1Eb1pK?=
 =?utf-8?B?V241bUtJVDd4SWIxZVoxYUpnMS8zS3VsZjRpeXhqa01yZHcybE9sN0dGek9l?=
 =?utf-8?B?TDg3Z05ZSjN3UjZwKzVaWXBtWGpxVDVRWDJ1SDFFVXM4SXFoaEVCK2EwNk1U?=
 =?utf-8?B?K2xVUlJvb3dPYlJDTmZMRGpIbkJlUDRmZ3hENWVmUnQ2VGs3Y2hCQnpRYWh2?=
 =?utf-8?B?RXpMa055dTJLNE41L2FBWGE1N3FwdTVxUjZZbE5sd0cvWTZoVmJOenFZNU82?=
 =?utf-8?B?Z3VGczdkcWtDdFhjbStCWjZ2TE1wRXJrc3ZONEV3VS9sQTQrdWk5VHRJa1Mx?=
 =?utf-8?B?NmF6WXQ4VTd6TzRmam04SklkcTd3U1F4L0dLVXp0bzFnTGtVaFhIVEZON3pj?=
 =?utf-8?B?R1hRN2pTb1VNUVdOS3NJNU85SzN1OFVVUkZkSVhCVXFOMWJUckJHVVFIMVRS?=
 =?utf-8?B?amhmUTBxdjhaS0NNOENUeHpvcWM1SDYyVVZua3dXRmdQa3ZYVXd2UGoya2Vt?=
 =?utf-8?B?VlBHcU9CWm9McjJDRkJoYkowRU8wTEdWd21LcjY0QkUxTjFuUW1GbHNhSnU1?=
 =?utf-8?B?aWo1dDVTcU9tYUdSMUVCbm9jTkc0NlhEcVc5OVNJUm1DcUEzNmNaS1M3ejVB?=
 =?utf-8?B?azZ5RUFNNDFIajRnMG44NEQ0eXI0K0tDOXJqSStEbjRnZmZjc2l1RkYwZmZs?=
 =?utf-8?B?VW1JRG5pMCtHOXVMTnYvYTZtMW5EN09WQ2pBQmlWV3NhVXNvem9pSG5wcTEv?=
 =?utf-8?B?ZXJTSmM1UTFYakcrNnN2QmpSUUc5QWZBdDdnd3ozajZEOFk1R0NEYVpOcktE?=
 =?utf-8?B?K2xOcHQza0dRZXlrcnpHWGJGT05zOU44cFl3U0l6TEJhL3BUYnJQZ2VkcjRp?=
 =?utf-8?B?ZHhzaDdkQVhLN2ZHSVpPK1Q5NG9QZTZ4Vi9iVWhVd3ZCdGh5T1FBUEJrUUpD?=
 =?utf-8?B?bUVMOTg4THB5cXl4L0hqSVloUVRsSno0ZEpLdXBNSWRMVnMxZHhtRXUzRjFT?=
 =?utf-8?B?cGRzOW93bnFZUXNwWEt4QmJTYm1Cd0dzT1g3dE5MVVl3QWcyYlN5Q1RVRkJj?=
 =?utf-8?B?V2haTmx2WkVBeWVqQXZFaEFmR21HSmQvNUhiSDFHbVpwcG5pYVpkUnFITkRM?=
 =?utf-8?B?UTl1OXJuakkwT0V4UjdIeC9obXdtam1oZi9jSDNLQTZibnRDNTdjc2xDYTc2?=
 =?utf-8?B?RENFcm0xTEQyYmg2LzI0OE84Qnc4aG9ZQWM4d1p2ZC9lZUdXSE5iUUpqV3pS?=
 =?utf-8?B?QVVFSEhoTkd0TFFQL3ovSU9FemdBT1A2TDlOcDFrMmQrLzRIRXpaK0U2K0Fa?=
 =?utf-8?B?M0RKSEhxZS9pZ2hqZmk2VW1LSkVkTnJoRDNhTzJoOW5VOWdLSElRbEV2OUlD?=
 =?utf-8?B?WWxlQlFkOHd4eWRmeHVlY2YxdXV4RDkxLzlxT010RWxDcU03WnhiZHpmU2Ni?=
 =?utf-8?B?K2RDWnRYNG1OR1hnc3hNTzVVV2V6TjNzQStMdlp0amFxQkg4YkxHKzhGZE9q?=
 =?utf-8?B?SXZrNFYrb1ltck5WRXpIS1ByVjJDNFdtYzRhWkI5VkVyZ3J4SmJWTlNFajNG?=
 =?utf-8?B?eEl6LzRVKzhaTXdlcWROK2JqVU9CS3ZScWRRUUY0a25scFYxRWRnWFRtdldN?=
 =?utf-8?B?TUwxYmN3Z283REozUGxDMGViVEpTRitabmpJclBLY3lSWXFmN3k1VmVneVBm?=
 =?utf-8?Q?AawWGVpLXniWZ5TNPnorEEo2l2BV05YwFkzc0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXNvYm0yUjJHUWtPWHNUQU8xYlUxN0t6VVJ4c3ZYdmtMZ25BK1U1SWlEc1dv?=
 =?utf-8?B?emhCblczSXBqcFBSQUtwQ1AzZzVMZy9WYi9vYXJMN1BwRmhzWUs3NllobGxY?=
 =?utf-8?B?RDlGK0pzOXdjcEpDTHZidkRJUXNqcVNxMld0NlNKamd2a2NwYUcycTJCVU9n?=
 =?utf-8?B?VklXUlZGaUZVNnhzblh0MWU1aFBUams5aFZjZTdXMHRwQlZKWnptWmYxTG0r?=
 =?utf-8?B?WkRwWk5KY21LYiswZ1F2TEFmVFJYVkRJMm1YRG9Qc0dRejJGbXNEOVJOQ0l4?=
 =?utf-8?B?elRnYjU5ZDUwWUxoUzJOeEM3bTVRbnROcHZnYzhYNzdVdS9WZFpBaWNtWStQ?=
 =?utf-8?B?Q2pzS281RitKUkdqQ0NMU0lTRllHSVdyeVo5eEtpWjlMT040YjBkc0pkSmJZ?=
 =?utf-8?B?Y2dpYWNyWUNwTk90dHNlZUo0anR6RGJFY2JVa2hSVGV3U3hoS0I1UGF5SWtF?=
 =?utf-8?B?YThvWXM5MlpLbUhYQUk5S0V6YXBoYWRrRkVDc3liV25VZUZISDJKdUdTN3k0?=
 =?utf-8?B?UnkzblNzeHZVckN5cnNpNlY5R0VxT21MUjB1cWZETUdaaXg0cmZkaFJteWlB?=
 =?utf-8?B?Qi9ONlFaZk0rbThsRnFZVDllNmFvNThxcm1zU2hUZGVKUkV6R0taeFEvU3VM?=
 =?utf-8?B?RHVFRjRWUGUwRjRmaGQySzhoc0lNcGdWSjQ1QVlFalJiRTV2UEdMZmJhTlNW?=
 =?utf-8?B?ZDV1Snd4RUplZElCQVlydWhMUXppaHcxaDRINUJKUjVzYlkySHNjdG1DdCt5?=
 =?utf-8?B?ZktKRWFxdk9PbDRqaVBxVVdIbXRmUkhmL2xWSmtBcVJTbjBFaEZHemtMYUp4?=
 =?utf-8?B?L1d0UWtHcDVyS2VoQlZaenBIcWhqbzBiV1J3THRCcmViM1FmNVZjdkpmYU1a?=
 =?utf-8?B?MHMrLzJkeXk5cEQzMTdBSFJKWXRZVWgvSG1oY3NXaElhRVA3YWRQSDRnWUly?=
 =?utf-8?B?enZtS0psVTRuNDdtdWRWUEhYakdqbGlVQ2gyNHFRV0E1ODRiUVdIak5kWXh0?=
 =?utf-8?B?ZzA2YWFVOXFocjYrMmFzc3huUEpqOFp0NXlKN2lrT1QxdWErZ1dQNFBnSHZK?=
 =?utf-8?B?bHRzNmc2U1NUY2VLc0E0TGgyaHZLdzJ4MnR6OWlzcitmajJCYTUwT3dJMUp2?=
 =?utf-8?B?NVhEVDhkanU1Q1lDMytselVCVGF6QnpBSk45RC9BalUxNDZscjRrRzJYZEJW?=
 =?utf-8?B?KzZlS2tmdlBtTUloK1d4OHlnWThkMkpsTHVkSTBnSldMN2RwUEpxbndrdkEw?=
 =?utf-8?B?MUhSVFkvZXpkN2NjcCs4dzRHSFRmT3lwYTN4V1pJRi82OCtSWUFDMXp0Nit3?=
 =?utf-8?B?enFRdm1RZ0dOWEZ5RnV2TXkzdk9PeWpLRWZWUURsNWxtczU1bVBtOVBMa2R1?=
 =?utf-8?B?WmVlVnJqdW10d2UwT3NBOW1lOHFadjF4QTQ3QUNCaCs4SUtya28xazZFRi9E?=
 =?utf-8?B?d2wvS2RnSXVQOTYyTTZFTE91SEYrUXgwWVJYVWZEWGdFUXVnemhXWnM1Q2R0?=
 =?utf-8?B?QUFxOFJNRDdBMGFwczA4NlJFclhHK2k4RmJXZXdKUzNFZnNuVEpzNHpUNTBB?=
 =?utf-8?B?ekpWRWQweVE3QTNtNnFNSlUvamJ4LzJlNHI4QmRyTVpkKzZTYkhwWUpaellC?=
 =?utf-8?B?QmMvMy9NSlZXaHMwTWp2UkFCOXk2RXViQlN6UGJDYzk1Z1ZNT3NkNnF6ME9M?=
 =?utf-8?B?anJVSHhnQlFaYmpHdmNVZnRyd2Jad0VmdFE5d0VWYXdzKzcyY3AwWUZheHJK?=
 =?utf-8?B?ekxWWmtjOElEalRYSXBDdFFtU0JvcTN5VjJpaDlRaFNiN3RsdjZQY245ZTN1?=
 =?utf-8?B?Nm1mc2tlcjJWT08xUUU0OC9WL0NqYmtTMitzSDB1ZmMwK0FtVmg5L0JVbnRH?=
 =?utf-8?B?QVUreUJ6YVhJQXZFamdGZVlWWHVmWUMxNnBJRis4RGx2NWVhcWNZS1kxTTBn?=
 =?utf-8?B?L09sVUpBcHd6b3R3RXBNT3JDS0t0Z0pmZk1iMEtjV0dZc0c4djlXeHQ1dHY4?=
 =?utf-8?B?SG93d01rNkJ5ak1rTk9pTFVCblhCM1VCUkV3Ymw5RkdvN0tudGllaVcwb0Np?=
 =?utf-8?B?TlNmYzhpZ2RiN1RpdktzYVFrWGt1bDdZaXFXSURHM1Q5MXBnT0lYSjZoZEFW?=
 =?utf-8?Q?34p6zLfqiHiOmyEidZYv3WziJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e99a82-bff9-4492-ba7d-08dcea09dcbd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 15:32:05.9771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFKsWBLy1iZ/9aUtR2af6dxuthCUaNhrthmyWa/L7QZlUiFUxP6lxL5iv2GgygtHcsW/d1LOBMPm4eKIm4cFTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7360

From: Priyanka Singh <priyanka.singh@nxp.com>

Fix undefined behavior caused by left-shifting a negative value in the
expression:

    cap_high ^ (1 << (bad_data_bit - 32))

The variable `bad_data_bit` ranges from 0 to 63. When `bad_data_bit` is
less than 32, `bad_data_bit - 32` becomes negative, and left-shifting by a
negative value in C is undefined behavior.

Fix this by checking the range of `bad_data_bit` before performing the
shift.

Fixes: ea2eb9a8b620 ("EDAC, fsl-ddr: Separate FSL DDR driver from MPC85xx")
Signed-off-by: Priyanka Singh <priyanka.singh@nxp.com>
Reviewed-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/edac/fsl_ddr_edac.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index 7a9fb1202f1a0..ccc13c2adfd6f 100644
--- a/drivers/edac/fsl_ddr_edac.c
+++ b/drivers/edac/fsl_ddr_edac.c
@@ -338,11 +338,18 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
 			fsl_mc_printk(mci, KERN_ERR,
 				"Faulty ECC bit: %d\n", bad_ecc_bit);
 
-		fsl_mc_printk(mci, KERN_ERR,
-			"Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
-			cap_high ^ (1 << (bad_data_bit - 32)),
-			cap_low ^ (1 << bad_data_bit),
-			syndrome ^ (1 << bad_ecc_bit));
+		if ((bad_data_bit > 0 && bad_data_bit < 32) && bad_ecc_bit > 0) {
+			fsl_mc_printk(mci, KERN_ERR,
+				      "Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
+				      cap_high, cap_low ^ (1 << bad_data_bit),
+				      syndrome ^ (1 << bad_ecc_bit));
+		}
+		if (bad_data_bit >= 32 && bad_ecc_bit > 0) {
+			fsl_mc_printk(mci, KERN_ERR,
+				      "Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
+				      cap_high ^ (1 << (bad_data_bit - 32)),
+				      cap_low, syndrome ^ (1 << bad_ecc_bit));
+		}
 	}
 
 	fsl_mc_printk(mci, KERN_ERR,

-- 
2.34.1


