Return-Path: <linux-edac+bounces-3747-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C3FA9CBA3
	for <lists+linux-edac@lfdr.de>; Fri, 25 Apr 2025 16:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE3A16F312
	for <lists+linux-edac@lfdr.de>; Fri, 25 Apr 2025 14:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E429A257AF4;
	Fri, 25 Apr 2025 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Bk+RTzV1"
X-Original-To: linux-edac@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4726D256C81;
	Fri, 25 Apr 2025 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745591215; cv=fail; b=XQRNrY7azAJXSK3HdNzhz8nFqf089gxeKefTnDbeRbwCOR9XIpwnCIQkg0OR7dRwSevDqwMfIqjcE/VP58C9SG3hUVks4vx7Y+rQws79NEl2pZJ0iXngcUCyA4rQpG6ahLEdUYtgpk+6SqiQdTFFJUqPPntF27QcSL9fWJ1uy2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745591215; c=relaxed/simple;
	bh=xR+RYENLrgJdKiLKbKvhsqNbz9SWnL4x9nsq/fpnLQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FnzUPUtHZkD02PHVQ+wq6GoxSkxKcglBpwpaRtWPLm7vw7rse4WAWqmIK1df4nzqXUmY+quNZ4VO/d0sWtfkRTDpwSKKspaZ6Bn2T5fSpooNV76Gqsobnvo7TFxynPbq9YUthun544l4C0JkttZMC8yjuwnonRX9FzjxlrxyZNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Bk+RTzV1; arc=fail smtp.client-ip=52.101.56.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o22WLXvXF0uMR2BS7dkaBGtC2oqg2cO1F+BuxqG3yLzWeUSE8uKCA2l20tAsDryiR+k8qfGzdKSDx2OVZ42EG45txOGl2S/eEf8KFw1MirIggx2fgoHgepr80QY/0TgShjM1wTshxKxtMSTgSSMcuQleoS7L8lGo3iIVGv0IDklq9TMtOaL7UW6ma2JsfmB44Nr+iQxsm9FNOueRqpqDCK/XlX7eOWwUnhrYBBg9Hlf8nGS2t0kkA4zQDLS0US2Mp5959k/7WTlCPPrzCZJHaxe8bODseIuiIIDKuYn+wnL3fWfqNSXst6rrwR5xjiXj5EfNMQWuCj+MJZ2LjMar6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qD63EMyS+ve1F05agB2ICDuPxJBgDSa98ugrFGdEj4=;
 b=F26jXpJlX/l2D14wWnRF+3LaoRtrd93X8UG3lFzaB3PHeypzUVRlBAJ91VEIMcoxuDxbY0/dV8jJs++EYI5g1OdJqUss1YykZYygE2ZahkBGbrT0wVL886I40tWzCRHw3NrebomUYB9r1IF5EvJz7glgnpx97pKrq9sxUKVZMifh2ED/wdIH4freDAC03wCDFY8BY6Put8KaLqW898u7z1w+YKoq0Wu58+emXib8sYdgO0wUsze/P2eXvpI5v0SLZI/z+4AuYdvM18p1m1GT2sn8zp56E25VEgDVbTboof8s6n1/HlFQt4a1GZ/lXRt793kCIJDgOMR8pheXZ2AqzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qD63EMyS+ve1F05agB2ICDuPxJBgDSa98ugrFGdEj4=;
 b=Bk+RTzV1abz78aJ9KE+yc7HQSyo5OHNDh+7UerJmS3KnjgLLI58HNynS6Qyny6sUqbaf079l6/B+z01Ppx/u24ojKtL0xYjiN4cmbpQ5yau+J7urgwhNIzCx06JW9XmdBuH7hTJTh47KOpKT2DJ25Fqg0NWEjQx5PsI4r2Q5EK3WztkBKEquf36w1tsURwsUkzDAcvq6FjW0TJbXVyyJjmFWEVmThuq6l/rSLsz89yIwpx9UX336Q4C+fX6s53p89E9YmrfNyt/mZEQhEJT/3gRTiTguDxggk8XzMX6a7aDb+jSrdKvel19fwf/sjAeqvabb8vfaCtaH5uRp/INMag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by SA2PR03MB5818.namprd03.prod.outlook.com (2603:10b6:806:119::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 14:26:50 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%5]) with mapi id 15.20.8678.023; Fri, 25 Apr 2025
 14:26:50 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: dinguyen@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	tthayer@opensource.altera.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>,
	stable@kernel.org,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH v3 1/2] EDAC/altera: fix cut and paste error
Date: Fri, 25 Apr 2025 07:26:39 -0700
Message-Id: <20250425142640.33125-2-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250425142640.33125-1-matthew.gerlach@altera.com>
References: <20250425142640.33125-1-matthew.gerlach@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0014.prod.exchangelabs.com (2603:10b6:a02:80::27)
 To BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|SA2PR03MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ac93b9-3eba-4124-dbf0-08dd840536a2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hhbxiOLyYrQKuEBS7n8j0E/xB00uxsq+m/M4xf8U9SMwwtMjobJhFuyrctjM?=
 =?us-ascii?Q?7Jhjz6gv+WHA1mUcjEChsKsALKSHs6KRbHnFkbc/uxQWEuaarxOPk40f7moo?=
 =?us-ascii?Q?I/XgH7avEWFei0ZCs3xukPjEtuP0KwxQ/DYN/e9PdkZtmNboFif32tYuAdag?=
 =?us-ascii?Q?qVG/hlJbIeCvU4jugzmgndzyt4bEYF1Z6iAKQjIVZqrssq/sGXPCjZrdWphE?=
 =?us-ascii?Q?eiGa74j7rfPL8BCxGLq/zOQRrFSgDxH3v1iHOz0o7UJOwjw/T+UrISq+DQLJ?=
 =?us-ascii?Q?qts6eFsKMvDuIgEkU2bez0LO/1VFYAZNOXMhh60uOb1XMQI5+GZF0iaLK1tH?=
 =?us-ascii?Q?HNHGYt2TnvSHYl70cSKVVidAK6fesr7+qgp3//2g/bZZ0rXGUPaouuM2rjzV?=
 =?us-ascii?Q?UGFBq6JtsKAOOK5Y3LOKA1NcLCIztbtMsrcUSfH8FMrQWis2yo8amRxcz7G5?=
 =?us-ascii?Q?Xdpg3GJoCVtRIFyNfm8ezcVS83ROmK+GayjLx79vbCKGdoc3kkeVDKJwhfxO?=
 =?us-ascii?Q?S6ReJ+/vqYsagLnAC7bnWv1kd3R/2AiUcQ0qEDVYqX0EwcjDoiO6paMk5xxC?=
 =?us-ascii?Q?8EsVExYcqqhTgqmBvKruHvzUDJuc9VBNUvaap/VlEZX0e2zPqtbOI3zsujCt?=
 =?us-ascii?Q?5WnfouNvuLEFZmltE1Q9kKXw+GymaS2B+ssVltHbO8AcFC5JD+i/dJVlrTlr?=
 =?us-ascii?Q?cRaxOoQTLbrrg+XgjWhPXsgC8r+tEy3HCScUpKr+kzFEnwYrgIbRM6/Ji34C?=
 =?us-ascii?Q?KMnb4/CLFuMT7HlKun88WjVf4s/qwlj1J4zg3j8sn/4c4d+f4zosee58qfnH?=
 =?us-ascii?Q?O1chVQyS9NMuM+REhnmOQ8G2MdaRVLZcATUF+cz/TndcD/r5UFjH+r/7zTkN?=
 =?us-ascii?Q?WfrCLnpzrlnqRCewHDi4u3TCHCP4Ynwz8PF1xB9FFPCBGjEHcrEId22mn0GC?=
 =?us-ascii?Q?U3arDF1p+gU9kIkJtDBb5THB7uix+NOM/5TsuSDwtKeU+RZ2e2afDvkLBKxM?=
 =?us-ascii?Q?b1Os8vEQNQPSwLqRJxKbygFPOLyjcrBlanWcnUnhQx11XhIBwCnkeJGU811X?=
 =?us-ascii?Q?IHb+ZROZEbxMf2FaGM0sI/XsOVPM85y0FWwfz7otRStz5GhptjqIe6aGzofB?=
 =?us-ascii?Q?HD8krx/p7MGZTESUG5BmE+QUysnNVF2GJzsBPDSE+YsYDLZuoGIXjAZ+0dKq?=
 =?us-ascii?Q?s1QYeuOJXlT14t9ueiP9wZQ6kxgvVrScPzqONY1Y65syN+wRFWKq+nryXsgY?=
 =?us-ascii?Q?cfFvQz4uovGltroKawRE2PZH/9HbsBj9HYQLRxM3wj5PQ3c+T7boDUuYNX1d?=
 =?us-ascii?Q?EpSRFbsLDH9p3Z2C5Y3Kdsbn9E7ELwCzOvqZy32a0PHZ/LhLKxyHyYhK0C/N?=
 =?us-ascii?Q?ZL35GoR0kR85hjdHXy+9AX+JRmHlATJuI/t7CfyvAyE5351sT0BNwGn54YRJ?=
 =?us-ascii?Q?BMZbhehWW/s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kNc4SCd9cGKosxVsmL4/qm28nDX/NyScsPbOMQDTkX39lLvghSTBfAZJ+5x9?=
 =?us-ascii?Q?4/3akbv7kIzjFGV/D37JxNSA64zQPqJOypJwixAdh9nvFV+EKcKuk2fiqOQf?=
 =?us-ascii?Q?wbD8/0RMDQ27owQWhcGSC5f/egh/B7slD3E47J6GvmVzjI8NqL5pANI+IWC4?=
 =?us-ascii?Q?FIez8DdSahyo816xXhSsy4VKYtm4UEiSsn3QI1VVaDzfngeuKHWK9ajWAYLF?=
 =?us-ascii?Q?kU58xPm2Yt/Su+Hzuj/l3yiOxsCGzfC1xlnwdnGz5T3JjkUzdYVMW4rnbKOz?=
 =?us-ascii?Q?L7b+Dp8NwD/YAZWUpB4hmtttRE5++PulfMoSq3063Tvk/ncPrOLGjAB4Rsg2?=
 =?us-ascii?Q?5zf9ZQ4dTdXfm6m/F479cdy9M27Ee0F7v1y0ETXVC348jdvZLod4Wtk9IYBh?=
 =?us-ascii?Q?8CBB6TVbKmRZOPuXCZnREbtjHxuA7GG0M2nDPIscrO2lCwU2s3LH4x8crpGY?=
 =?us-ascii?Q?61CKUbR0x8JcHPhqZvQZjhxNbScPQ0d4YsRQ0ERTUU4rywg0KZwOGqx1xIAZ?=
 =?us-ascii?Q?jfNFDOEMy/YNdZRIM5+I1taFgkpRliCKfqT0gKuYJ+lxWjvMQKaXFvrVFUlF?=
 =?us-ascii?Q?xkOhAOsrvdQp4J0dJXMOvAQ5paTzU31Ko5s6dga6KDUtr6rXXOo+V0lk0C3z?=
 =?us-ascii?Q?q+909glrKV46fzDmpuUW1ADMOTx5Iotx5McUI08MrQ2ifuRPC9PE17w+Vh/Z?=
 =?us-ascii?Q?EGP1lWlUc4P6HyO+Xi0qgnn8W1Me5/UsAFPtZoUw5knbwesKNrr0FWNmK4lu?=
 =?us-ascii?Q?PHCuk9QlO61X7RhQCghRKR5XRZQsUfIFA5ph0xW9FsEAe2I+H28M1PoYAhhA?=
 =?us-ascii?Q?riT9NA9I5y+c1/RVl8POAJ83+yAUqJGZhDvZiIf+gwpj2NnIzfYS7JX1MtzP?=
 =?us-ascii?Q?nT5jmvoHSeoxYaYHhMTpEMlFOTBJ4z3TiD1rLL5h5+5b8ctQc6pus6YMYAAI?=
 =?us-ascii?Q?81uZfk+3Yq+33RXN7g5VpUoz8cUQHDG3PuOWd7cyJH5Bm50WdF9ZCqai743v?=
 =?us-ascii?Q?UhJ/x+WZhOTP+M++xjwGfNIE0Bna6y8DSjtYYY9NtMhz0p8bf8Dw3x69Mikm?=
 =?us-ascii?Q?x5dHHKR9vKQXRy/YC7tU0OrbZ20Sh2DgISGBNxvlHJwffoz6UqDO9SE7YHYh?=
 =?us-ascii?Q?m/uPRSlcdVEZkso8UkrjKquh6Hx69ioj75HO+IN+r7jFQON1dIhOWGuB63+U?=
 =?us-ascii?Q?RB7PpBXxiqPc3qYig34MktKE9SaHRr45jNmlRxAMdeE3Gf+bmns5VIwIfK6N?=
 =?us-ascii?Q?V3QY78A0fIWR5xyXs6/XcBkRfwJom8RFUL3rOlD0QDXiRMOtUIXwc/Et652k?=
 =?us-ascii?Q?8nWNCOJCaUgk45qXBjSlH7cJUJbePyCmSgTCwxsLHJ9001TmlQlpOhcBC4FO?=
 =?us-ascii?Q?fE90DOUx3ekU5NuEONnsN0UrrnByW9uQZ5H82Yq81CUvSIaDoW3gHvR3oSe7?=
 =?us-ascii?Q?YrEatBK7qed5fGrogq9L2+e3hy38+uay6qMPwUhP96LDQxvzUtyfrujs5tjL?=
 =?us-ascii?Q?1A/OW85zJ7F5FWp5LG0Zhc9svXWDSBGJ+NcpPttE5abrkI2Ya1yLaHcMxBrz?=
 =?us-ascii?Q?CrDXxoschg4EbS8u5HIsjV2glNtkEbkrdAapIdUin5ZstoQ39OvKJrUe5Vo9?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ac93b9-3eba-4124-dbf0-08dd840536a2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 14:26:50.0360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVo2mQZFyjny9cYR26Thd6VSOMU91i+E0AS9//70B0f2Tq58EtZiVCIm31ULUzUVpx+sDxKhWT+M3ailkmF+Xz24JW763BHqbY28jMhXFBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5818

From: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>

Test correct structure member, ecc_cecnt_offset, before using it.

Fixes: 73bcc942f427 ("EDAC, altera: Add Arria10 EDAC support")
Cc: stable@kernel.org
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
v3:
 - Use 12 digit HASH for Fixes: tag.

v2:
 - Improve commit message.
 - Add Fixes: and Cc: tags.
---
 drivers/edac/altera_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 3e971f902363..88d9d2f458ee 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -99,7 +99,7 @@ static irqreturn_t altr_sdram_mc_err_handler(int irq, void *dev_id)
 	if (status & priv->ecc_stat_ce_mask) {
 		regmap_read(drvdata->mc_vbase, priv->ecc_saddr_offset,
 			    &err_addr);
-		if (priv->ecc_uecnt_offset)
+		if (priv->ecc_cecnt_offset)
 			regmap_read(drvdata->mc_vbase,  priv->ecc_cecnt_offset,
 				    &err_count);
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, err_count,
-- 
2.35.3


