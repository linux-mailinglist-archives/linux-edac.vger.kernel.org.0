Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436CB3B2125
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhFWTZC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:25:02 -0400
Received: from mail-co1nam11on2042.outbound.protection.outlook.com ([40.107.220.42]:24416
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231243AbhFWTYh (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:24:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETX9QaDgyBapL5Iw+K/szR4nkwK/BJGikeFE9wRWYflWvMLkmXGy2KtWalJgidrgwMOXTNuZKrRcL4/qwxmBH+7t1Kt7k+me/IHx2oMNLEBF8FeBZhVOOJNkTEbd6bSsc/8UIYEdYC6ikdJBOZqFlkPDrIpcSiIZlVU1Q/HiefB4qfeFZnFIG6UdSm0OTrzeO1zmDAUpsYPt4Lgj8TL8P2gJHsFCKT/SAETfjHl4rMZxMqyggAA0XRHILOBBuMwmP9imAXEkUR+PF440e89A79Y0GkhJ6FXkxv4ihuphPnv7mTVgz2Zwu3/gmN5FvtH8CdRRUCLzdAJNDyTJO11n3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsmFwFqrUUgCBXXWxcduByI3xRY8pDPQQXOhYdxr+JQ=;
 b=M0+d0GQWNn0pW3x8NMTO1fDonHDYm7MYEPsuuzZ+aP6USuhkFnbshzOuJsXp/QqvKr5YRxCkqJ6+qcDYXR6+Pb+riHnlX+nFI388+g8GgsztlHLSCLnj0GSgGf2g4bOo1tB3tobcqI7GirR080WlU/1svnxeDFvlz9fUfgxxPKPSfTOQLr39p+UlG4kHu9FQyLw7DHv3cIkQ6WcJYcTHbsHK9MuAVLDQE8dvLWNO3qf2t19IT+SIBZ7se03BQfaqhQNfvuOgQs8jGZERla2Ah+mhKCGTysPm1t5FqoOpa8PHR7WzBBQ1xzHfGxULo0BZm+FOLzC1KGmsCY78GjyAJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsmFwFqrUUgCBXXWxcduByI3xRY8pDPQQXOhYdxr+JQ=;
 b=enmgnf+i1kDrjCrA0ysM0NvxKmWY49Hd26iqAo+EFpKjjzYfk5gIiq+JY2GBj3Ef6cj+L2N8Y88+xoc+BASakmvqCh80YR5CZiWfDi0pP5f7pGgYV1D2QOclphYuthUFcekg5o22BBiNHLHQSIaNlzmUmBDYEGcj1pyJ4pd6Q2A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3218.namprd12.prod.outlook.com (2603:10b6:408:6b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 19:21:04 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:21:04 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 29/31] EDAC/amd64: Define helper function to get interleave address select bit
Date:   Wed, 23 Jun 2021 19:20:00 +0000
Message-Id: <20210623192002.3671647-30-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210623192002.3671647-1-yazen.ghannam@amd.com>
References: <20210623192002.3671647-1-yazen.ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.184.1]
X-ClientProxiedBy: BLAPR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:208:32a::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:21:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dad927c-ade1-4fd1-9f1e-08d9367c0b4d
X-MS-TrafficTypeDiagnostic: BN8PR12MB3218:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB321844F0155198299BACBDAEF8089@BN8PR12MB3218.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O0DdRwIMjjY0gRDjJQWm+BqLRCznuB8hlhMhFCYjybYY8LaoZS6KHhXMOJ2LpwKI90EZE99gtqLQB06SP6cn0BCNjTAwIgfAnaFfvAj881Hfye4ZikiQNXUWhnaPY9LNYR877jK9fAGrmIfR3+8gTO9ken+g1nCMc+FgyBFUf/DBhDmyD6scCSSdZEMRb/b1xSXFqVQp2zx66WpBzbKVJaEARXqrE1AH97qE0EPO71CPpZX6M6SCe2yV7iIt0LgwQNCfjbesrvG0UH4NM9NeYWmRQWOnZRHCnTOjQpZWI6r/cLPEcZt10JyGm7k4w6jj9Y/IjN75LlHTcUe0+p6eytdz66M7MmkumE3ILBXjffPd2Yx0kMfIkiq4HzFDv7pE+PNdGu3QmJ7WkypoVsML+OvQeqfQsQK5X5rhF2aqO84VzvoUz0uBadvdu4zE/7jvPmPx4dPPH2LkEqK64ax+jP0MxVSFTbEqReu/7im2veQQhWNytTf6A8cOqMUpZt23tpGpZUrmycZ6cFP9/DAezMZOnR/IbZiAle0uU3s6NV/kA9EKUTUatO9G7Y/UxNMKGpmLkigIyMAOcryz22wku56pkxZ6FaeAN3tJJrRym3jCG6vDF7yCiJ9YHUKSOW8Ft5xw9uJ8zsIX7mg4Ql+uAX2AD+jJHxqEjCnBdffXuaniw+KNHLqMRwOu19tzes40qglDhww/BGB+d15uWmyEEaGnXyII0Wt5Xvnn26nIiVcIZnU7FWr76cWXIExe+of5zvm0lvPMG55C+2PHWPf8SKCySYZFheTwbhtp7yg+W9meZsALnnOOHUvLD27RTVW8Hw8gRpDhyBxjk7M+kplTzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(316002)(6486002)(26005)(16526019)(38100700002)(38350700002)(956004)(44832011)(2616005)(86362001)(2906002)(186003)(1076003)(6916009)(966005)(83380400001)(478600001)(66946007)(5660300002)(7696005)(8676002)(8936002)(36756003)(52116002)(4326008)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RqhUmVVaxUFTzf9ebIqR0jjcmpA1wqHznSqFiL5ZwvWVozgWp4FFMqlvuTTj?=
 =?us-ascii?Q?QWXdkdzo25g39mXpgeH7F9Z/ejBWtsJF2ONmB9T9n3gGVBrNjXBAts1yPTYC?=
 =?us-ascii?Q?HsTMURZmpqDSKoq3mMTwvJgTuEi5WCu1KNv+Sahx5Ak1AeHYSAZ2ARsBssaQ?=
 =?us-ascii?Q?IdcriSLGapQEKgMoZ0/a9TS82sSixcub/VRppQicZ+XtJ8j/HMorZM71B/en?=
 =?us-ascii?Q?oVKvC5MsfpqecB8ctzUPxWdC6G3bLnYQ8x738U+VhcHNgDbzOlgokPtN5igt?=
 =?us-ascii?Q?CQsyLlAXJaTW+JqXyGitoGbouRZmZus99vRD6UDiUy4QBXBoX+NlO801frWE?=
 =?us-ascii?Q?lj0mzvlF3DRkL2uhy+WyTQU232U6aQmIkGUhr1gQsrCFSFD+DjhS1fULXnBL?=
 =?us-ascii?Q?S30XGnKn6fE1aPA+8WQ9EUooAN5hZppXMe89dh3uWK+AaoOaNLkVnRB1h0cK?=
 =?us-ascii?Q?8oBCXN+k1cuhFSP1FfFX75Xo8folTcDCz9WARo4Ix0bulb2pIqnQw+5VI0zb?=
 =?us-ascii?Q?TGE9Ctf5xiQyWTAwCZGzhvTk1jq2/tO3kB0SNO9NGhGd9UB68SX3nUe0oYpe?=
 =?us-ascii?Q?Na6F4xaCblhI+R4nuGvj9vgeQEwm0j2VK8EsKQcuYgFFIc1nM3FrLHz8XepU?=
 =?us-ascii?Q?0LO1I4vjBRsdmWTKsQAnM5FYuHyiNAycALr94A8ocm75Vub/r+yD5zOsIked?=
 =?us-ascii?Q?u03n2Skcg8rhU4hw5OpnFQnLblbr4nB+EOjQV3KkFL1JLsFLUAHs8ZcVOcRi?=
 =?us-ascii?Q?XtT54PicYajdEYxVAjqGqQVlanmPDJOLWedbzhQcwCvqSTG7NitF+mrHgJFf?=
 =?us-ascii?Q?f5Dym45z5Q0PbrMWc2uGjxMicZ6K1JFE9ZGkBwF/9RihAztuqh9MDriI0WfN?=
 =?us-ascii?Q?cqoswo2PaC2fWzK/2V0EU73NW7Eiq1QqBfpFwqkEBgOZki0oHHu6HWQfpgDN?=
 =?us-ascii?Q?I+piLHYpNSlkXzSJzPwNsooZhEWfTCoS9j20cguyk6vYVwGArw0xJ0ULRRcx?=
 =?us-ascii?Q?oTcA2qRsD2pYE9FqouhR2c14MQOBzBYGiyzNZYCzVCzMJ6DXnbMV4MNSvzkH?=
 =?us-ascii?Q?sRRU4Ug07IUcUqtfPa59W8zh9goXwWuJI3oMSmYPbniTL7J5cDcmgJLLS7il?=
 =?us-ascii?Q?9d755Vek9hlKRBItskCAhMxRmtORo+aIr5JiwKycIhaEUloHsavMx92nu05l?=
 =?us-ascii?Q?STQxJrZ/Jj0igzKmfGzk/0QBA4yBIel0nk85XL7Kx0gfGqsVtmb3U245lTAz?=
 =?us-ascii?Q?V1qOt11tpgfpzFSJVEmUae6yrwpfbo3+EUn02gTFzKJ7f+rPukV/D8ZNmKrs?=
 =?us-ascii?Q?yuNTRfGRwzd/qeR3Sd4KjTfv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dad927c-ade1-4fd1-9f1e-08d9367c0b4d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:21:04.4865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhuxMfO97kdXftcwnAoVjYmU9IUquIzUajG6t+++WLtUSStzRv+DFsI7MoIoWLf6sb+zjAq99rK8GJ5VZiWK9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3218
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

...this will be expanded for future Data Fabric versions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-1-Yazen.Ghannam@amd.com

v1->v2:
* New in v2.

 drivers/edac/amd64_edac.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 7ba6aa97e80d..aa8b8d0b319d 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1116,6 +1116,7 @@ struct data_fabric_ops {
 	u16 (*get_component_id_mask)(struct addr_ctx *ctx);
 	u8 (*get_die_id_shift)(struct addr_ctx *ctx);
 	u8 (*get_socket_id_shift)(struct addr_ctx *ctx);
+	u8 (*get_intlv_addr_sel)(struct addr_ctx *ctx);
 	int (*get_intlv_mode)(struct addr_ctx *ctx);
 	int (*get_cs_fabric_id)(struct addr_ctx *ctx);
 	int (*get_masks)(struct addr_ctx *ctx);
@@ -1192,6 +1193,11 @@ static int get_intlv_mode_df2(struct addr_ctx *ctx)
 	return 0;
 }
 
+static u8 get_intlv_addr_sel_df2(struct addr_ctx *ctx)
+{
+	return (ctx->reg_base_addr >> 8) & 0x7;
+}
+
 static void get_intlv_num_dies_df2(struct addr_ctx *ctx)
 {
 	ctx->intlv_num_dies  = (ctx->reg_limit_addr >> 10) & 0x3;
@@ -1245,6 +1251,7 @@ static u16 get_component_id_mask_df2(struct addr_ctx *ctx)
 struct data_fabric_ops df2_ops = {
 	.get_hi_addr_offset		=	&get_hi_addr_offset_df2,
 	.get_intlv_mode			=	&get_intlv_mode_df2,
+	.get_intlv_addr_sel		=	&get_intlv_addr_sel_df2,
 	.get_intlv_num_dies		=	&get_intlv_num_dies_df2,
 	.get_intlv_num_sockets		=	&get_intlv_num_sockets_df2,
 	.get_cs_fabric_id		=	&get_cs_fabric_id_df2,
@@ -1323,7 +1330,7 @@ static int get_dram_addr_map(struct addr_ctx *ctx)
 
 static int get_intlv_addr_bit(struct addr_ctx *ctx)
 {
-	u8 intlv_addr_sel = (ctx->reg_base_addr >> 8) & 0x7;
+	u8 intlv_addr_sel = df_ops->get_intlv_addr_sel(ctx);
 
 	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
 	if (intlv_addr_sel > 3) {
-- 
2.25.1

