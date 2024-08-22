Return-Path: <linux-edac+bounces-1724-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF2395B67E
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2024 15:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1C91C236E3
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2024 13:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28021CB314;
	Thu, 22 Aug 2024 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ImylhNdk"
X-Original-To: linux-edac@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2054.outbound.protection.outlook.com [40.107.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA1F1CB316;
	Thu, 22 Aug 2024 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333056; cv=fail; b=Rbkt2NE0I/FKw9wkcX4ByL6+Gd/3mfNXuQ5R36hvfqba3dVb0WHGkQfKjKA4s6aOOiAIXfDLbrFoFYMXnI5dqpr2DvFGOhnfzeCJGqHVkuCGDPtjE3Nij6Mu8M/oMRPqowSKu5n2EEDO4+jI4GTWovCkSHHbYfwHaYldsXjXHBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333056; c=relaxed/simple;
	bh=Kf+E9qi3rUTKuIJrqMVn0vNr7uITrKa0eINb/q3Pck0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Wq8EpXc0KBpKu3Zy5amQWvZItTX9JygHnKxxcts0wnOrM1TnmzzKApRe39QcCyB/G4zm7YZHv9LdcW48Meo576IU0uxRXQeXRpiPM34sEsThU/LTQjDUEOI7MzIR4R1OtoS4AokPTyDlsgvG1iZKYKsNVwxuKiVRKvPx916Bmi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ImylhNdk; arc=fail smtp.client-ip=40.107.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tb9flu2/lpF1ZhytyHvXwDTQGN33tabVYfKktKW4z/hLF0ochJ9nm9H05aqHwcTS6VoDDBX2mSAMfESkZI9Z3Ym3KMh4eEUJN+2/NfeL1imJ2744fGcY5LeElB8/UcqTZleAlKaVg/T2QMZo8/MmYkz6fhmXgepQtpIlXFJhBXhhQDigTA1XnrQQHfL5IcpVxY2nr9L01Dd2aY7C+2ezJUNxrRs3kUv3nl15yVRHc8+VJhPLvtmzmGITR2wLL/G5drHPgO9zbmxzLt320BWcTyQNC0EKERDQSIFAdZi1S0RZ67ZLxYOeVaS8Cj6KnwVQVRRsiL04SuMPAmBJgLxEGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qieW1PYyjBvk2+Z6EzWyjxLuGaFaB7cWOp+sldeXDPQ=;
 b=NqER3WjEEdSrW8HpIlU55CWyvIaAaNsBBgofEw5ckg1A0bokmbSUtLUubEPFxa811NsdQr9XEeR5wFw8gJlLiq3KVp605+R1NhAtggGaxFcjXwp41MtEpk/lC8BWxsVhrvCuWT0VTYnTox9CkuhIWz1sNJJVHDERfokFaMh5jotY01hOePEyJhJ5h4MK1xbs7MRfstbeCftrfbfuTPjQW8XANTWikKUwm1HpsnLTQC4ruGtQvjO7YEN7Mk5expZKCFR9UxwWwN+hzAXMD1qgyg2r6pm/lMAsxO+EJCJn2aYFGUe9nEdWxqnZJN6CaYFtSwV+PCmZN1/WWMotwdD2NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qieW1PYyjBvk2+Z6EzWyjxLuGaFaB7cWOp+sldeXDPQ=;
 b=ImylhNdkkSlb+shrf6iS/zNZGO8uxHnEgBj/DCOaglXAwHbmwMKGmM58FVOpPHOjQd1ffGe/C3b6ICLntJzSRA5n1ziuKcVG+LPAJ4hqn1p3in93UDXqV/qv7JB+b1dfhxiui5C+q2Zs0/7HwJO8dfV/gKEFCPTBroEAXSxUp1kl+6HDSdfUVO1yxWQcHv5eVseiZn/w76nC0Cz0pVrOCZLJgeynY4td1+I5LokB9aBaephfAwkbC0CbGhU0ccZf/SCS0BOrhLZuS+acyuZz7uwk8L520c63XpbAmxH+JceuD5uttFz/z70IbES/3mcvLh5uIF0bkc0288ztyLflXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by SEZPR06MB6610.apcprd06.prod.outlook.com (2603:1096:101:179::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Thu, 22 Aug
 2024 13:24:08 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 13:24:07 +0000
From: Yang Ruibin <11162571@vivo.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yang Ruibin <11162571@vivo.com>
Subject: [PATCH v2] drivers:block:Use IS_ERR() to check debugfs_create_dir() return value
Date: Thu, 22 Aug 2024 21:23:58 +0800
Message-Id: <20240822132358.2416027-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0002.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::17) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|SEZPR06MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: 1972f651-f6fd-4233-ecf7-08dcc2adb381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hcvUFt/og4YTpSYinRqO/3tHxCwHyNZLcQWCrwJ76M86NOyTbFZ7HxIumAOM?=
 =?us-ascii?Q?c65HBNFC9GqnarnkkokTVAa7hDvH29tTZhODRrbLNKDtQyln2ZYj1w8jEabw?=
 =?us-ascii?Q?i+3dWmvOKgJcieLzeJMHYYivT9uTqZuyj+OjTyl44v8UPwQ+/urKWfuPusbS?=
 =?us-ascii?Q?kEqL4CKxlXHbSam5NkppYhoHzHVdnosfwUwu0bk2NC/lZlgSM+8x2BqBzODc?=
 =?us-ascii?Q?Pqxcns9+1549y94PakmSlulspky2sqiaUnKF7UlGivNZdaAXodiSrwhV57n+?=
 =?us-ascii?Q?8lnzBe+3NBoTJTER8wDnd7fiBSoE/iWCCQf4QWj92y+/ARRF+CrpGXD784qi?=
 =?us-ascii?Q?jFMHgy/DLsECz7gBDtKEyc7Js/4ZTftCduUYAZoYbF3jNXNk0wAma8WX/CqD?=
 =?us-ascii?Q?oX8jgIg89cBUKXM6a23Hj+vGRUCpz6+uEEfMuDQnas/+vtoAcnjcDam3cP6n?=
 =?us-ascii?Q?6LCnzvBynU58AMI+cCnSI4rmR3XKEyZT8ckKBzHhWhoY7SWwb/ZRuxzhvKp1?=
 =?us-ascii?Q?k6bipSbQePuo1/CxZBht1Qhyb3qQy1m3VB8W2cDPWnJKX4xKq5aRFREq6aC3?=
 =?us-ascii?Q?RW70ZDzTQU8dbGGQB1EXg9b2Ts321muKyUndfEL5BhyZSEi8loaf67GTqZAt?=
 =?us-ascii?Q?1WObIH7Kcrrxb8Rj/iYqMSkSQbscovkiL6F8Fp6Kg1IoKpW3lfLvqCDsj+zB?=
 =?us-ascii?Q?R5Opk5THZt6u9nK9Be9dU0vB81e+gkZc1B9eAbUNSXQ/fWwAr5mNbcoh7bLS?=
 =?us-ascii?Q?vmq1c9dJRxOxz2H+WurkYcccMass/U7ZiNvCjlXMAPHd/ZroLnUm5Hj/NoqF?=
 =?us-ascii?Q?Fq0OfQf7MkU84XVPnkrmvPkiYuJnZ21lt3a90wfidyNEAsxyOmjXySiUbXCt?=
 =?us-ascii?Q?yHVKb+qwJU6xFoUSc0KSJiS8u5APVz/v6Oq4uMbVaqQOPT2rDmLHJ50QJff2?=
 =?us-ascii?Q?bNfWB/CW17neOp9vMmAJJt8fuSfIgl4OksvI/35J5klmDJZovslFWTNkg/g+?=
 =?us-ascii?Q?kevJmDn0dPx4r0e/IKGh5BZXCZk2YoMojOnN6XamMvWmT9n2r11kMEUC12ve?=
 =?us-ascii?Q?KwCvpeE8K2+mb1voe2fhK4GLjxLVWalhix4GhsN260jP0sCnkm8EQkwbqdkM?=
 =?us-ascii?Q?dZ57InOydWI98tRwIjGrGCGjq8WPvLnHc7yQJLBzXcD58z7HM+/wOM6bmNno?=
 =?us-ascii?Q?870rXp3x9rM3HKaQPx1BPO3hjALA1V4IN/Z47/ppu2bR4gPbigRnAbn92fj/?=
 =?us-ascii?Q?/o7R+gZid/bMVVLmU5yef//IFotqCFR6Ri//6seEbagEtw8lq1sO7AmpZtOQ?=
 =?us-ascii?Q?4FqwIPThiORxrSMhLX2RuR2emKdjIO8zbhEkqxloXWQ/4z+CkIy096yHxlXi?=
 =?us-ascii?Q?8+51EbJgBY5dFkhHjjlMmfU6KqQAhAhkQj57UwYDdz58M0cMs7dcv+PzEC5V?=
 =?us-ascii?Q?6Pi2FP+wC8A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uE+Xft0SZ7TQGcekVSlYi9YzpRKbHBQGTzpwz5TUwEaZTepSaVuENK1NP7gX?=
 =?us-ascii?Q?ZZQfVsxlwSbC6Fa5Za7KaACifigityxeB3T0+SNrsPgJxdxQQOxUuJIu3X3P?=
 =?us-ascii?Q?TLVWq2rdUxOt2/noUKbArQbAKGSdRiIzbsJ9eaVRSpGT0Xq5gjy6S0xEegCP?=
 =?us-ascii?Q?RS3NS60krXhCslC4xkOdVI/Lou23yqMpRDOvrz8kIzDpQxa15+mcSwZ33zWm?=
 =?us-ascii?Q?uHPA+cx3GSO9Tcy4/HS2i+MCThgI1qgOXoth3pWgANtAayv7qk0KALO+SiRh?=
 =?us-ascii?Q?npb5W+c9YyH7oxIebDrd8LEmwXTREW4Z9pGEa+XLapFS/dXyaaD2bSLeGo5p?=
 =?us-ascii?Q?8any73awtG715I0bekAFENEJ3NVaq3ja4bnBPRdpiwRTgYqn8vDoKUf4E5lz?=
 =?us-ascii?Q?bipesjNtWaIM1X48tzk+JnvOqTeComwGRPWviHSzjWkvevhCR8HtwyPOvpl2?=
 =?us-ascii?Q?ZO4NeyygH/KxxefYie5tBvevJaoSr+cLlnx29AJAsbupuslhyBEGbXEWOd31?=
 =?us-ascii?Q?lEtTDVCK+9cbvaacnnZIpWXEd4lCLvq0M/a/+nac7pkICki69T96oFtCBFuR?=
 =?us-ascii?Q?0BO8Jm+z32aWS4X+HCmzVCiLrCwvp3lqbcRVE5QIakG6NLIOEQewiRuqksRr?=
 =?us-ascii?Q?HkVzHngil9sX2UFB88INLYVmFUY+dTW3gtKgoOOwuxEHDr5e/98TEOufSDSk?=
 =?us-ascii?Q?6rO3nBTXKWwP0LwNrZPRtRdlMkyWhjpq+0FjVqCKalxdQWVGy7EDJXYgtbsL?=
 =?us-ascii?Q?x56hnpK8WlX1MwfP1WT/E+WoeiJyF/VApXmjgvnT6Ls7eA3OF+PPdSTkycnf?=
 =?us-ascii?Q?9F8dmc+ULCgEH/if2yP4wmPvBNvR6jeDNdkhzbruJm7LlvDo91/Mj5aWan16?=
 =?us-ascii?Q?Ry2jX7X3+FqOOd0k+O4y49WCU+FpVbFkYQR/9EYPJ/4juDUY0Rc1Sm99Pkyr?=
 =?us-ascii?Q?yasPaS9MImYsplrCHoyus0+bDhOFcUbh5imzJL8DPOFpGOOnGJRTCboFZYa3?=
 =?us-ascii?Q?8Nseoob4PS4S7g97o8UVzbEupopIo/6RNQz1YJpWEBjdp7b3ttO/qtcyMFaH?=
 =?us-ascii?Q?rmXBuLbth61EXuochAVkrHm+fieNEuT6E9pLdmsHToA1CgstC2jlQA6N1PFw?=
 =?us-ascii?Q?x6z3zgq9gm1ECRSTB0KGhXccx2/uuhz/UJdwcYTKYDBI/vRCSsgeyK+ZEvXG?=
 =?us-ascii?Q?EcAq0iKiL64nZMaNxETPLyTU/BMAYatSI9ktTC5dXIOkVahwy6sxHY9jT5QK?=
 =?us-ascii?Q?yDP15ch2aKeF5Q7Drw1/PvaxZOb1VrxZaoj3CDq+bI8TrMC4wVDHvA+686TI?=
 =?us-ascii?Q?0RvdnwXW8NyxTb6qLUvhbaqjjR1QYKY4yk95fYcePVV9W4FI1RQ999Pli280?=
 =?us-ascii?Q?6NatyFGLQdglE7SkdAoWnJstglr2J0aPpaic2F7jJ3bwglF5U6B4xr2Da5kG?=
 =?us-ascii?Q?o15uK6d6bTu1PzYElhQZnBueWb11C2BPBNEpgN9rEvBgmYaNsCtMBDz0+ZYn?=
 =?us-ascii?Q?/+XIA6eRByRSKvkDR92K8uapICVw5/zTh6q4DjjvCahpUFyP7RzgAxhXXebj?=
 =?us-ascii?Q?I/NwBFxhjna5tSIrAOiEqfg68ILEouRYpB5OzqDd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1972f651-f6fd-4233-ecf7-08dcc2adb381
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 13:24:07.8711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dQWEJA+DbICvBDeHDYqP3NoSM/xsSe5kVFweMbXWNtmKLuV8KHZ4EyMU0ZEK+XG0VfZ53SVx5duxKCWwiRbVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6610

The debugfs_create_dir() function returns error pointers.It
never returns NULL. So use IS_ERR() to check its return value.

Fixes: 011d82611172 ("RAS: Add a Corrected Errors Collector")
Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 drivers/ras/cec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index e440b15fbabc..ebd4631b685b 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -489,7 +489,7 @@ static int __init create_debugfs_nodes(void)
 	}
 
 	d = debugfs_create_dir("cec", dfs);
-	if (!d) {
+	if (IS_ERR(d)) {
 		pr_warn("Error creating cec debugfs node!\n");
 		return -1;
 	}
-- 
2.34.1


