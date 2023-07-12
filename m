Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BF7750788
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jul 2023 14:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjGLMHM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Jul 2023 08:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjGLMHL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 Jul 2023 08:07:11 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2116.outbound.protection.outlook.com [40.107.117.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E659FE4F;
        Wed, 12 Jul 2023 05:07:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjrDnwMc9bOpLJi31Ef56OviiR860lSHqnVSEGj/Z6pJS3nSNp9TS3kmvp2vCeXE85iELb9WAtByKvd5AgMXGBsVaxRbKUYrZ7UAUS10aPZZkhEakuS9228UAerjov308p10VEXW0EDgJp5tK+F2z+c83Ch63fJ7k31X/J8VXWMeqQpCnEtxwQNcdHVzp4z8lIvf4D/5/Bcv/7ALK7c+hqgpKeFiBbvJD3oDcyK6xifUvNbU2jH0zl3J9FqdHBNr7eA6x9yUrAyHi/lqic4bmm2rwmzZC8C8mCVdAH154ucGPys42QGNEOTMrdg41UMsfQ+Eu0ZtFXqgOaXfX/58JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywrlneogh8cbQojwEV4Do/qwFW1PmSYmGdHKyfV04is=;
 b=hol9/ql0vk+M52u7vz5CB6/9h0eFmBndglIYngz1g6bRcSqheOpT+rKYe0RqhsMALt6j7MUbAGi7biNrexWES9l0U/X6KOxOgoU9/RFEyrwpRbnYB7aibOd1j9BtA+dZajxVkmPApE4n+E5e3L0Av1NkeZC+FmbBHWo2jOYdXyVejpdK/Dh+uE8yB4COYG3dd1Ay31KsT3eQMALoMRFNoQdoMR592c2oB+IE2qo2F/JUA5SOP4D+2p++sOflNQlhsJryspdjLpEyt1ebf7JzBFlzW6ilfpGtjW3wjxvplSgjtH6arJfrVqtNCwiLLiHgVvcRbYOvjH/G9ZD/V4BcGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywrlneogh8cbQojwEV4Do/qwFW1PmSYmGdHKyfV04is=;
 b=gh7Cy2N+LHpdZQxnYn2aY7uW33QVEgHKWoWi/bYRy+htUVsTM3I0NMNL35Us9tCvf7QtNfmKm55kdFhBbcMD8ayDQ9vlBWQ/ka8nHYHzo14mMx5vGAy+zlrvjC2T8lisLuxaQ9gak3ic6KHWLFJvZ8hCzr5ZhBfyr3V5F0DBIj7FPko+lh0zcyJWoETEFkby+r/BVtYHiDbsVpDRAyWP6GSHX5DcrkkU/3Ga3uWgsybOZmFNSEzLYIt9kuqG15O4lMiV84VBtnA59S38YXSt6nerHrtZ25kXYx+zJV4cBeO1FNg8cMd66yiRN+rd4cGt7tRs+IhqOelxZgVu8UV2kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TYZPR06MB6499.apcprd06.prod.outlook.com (2603:1096:400:462::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.32; Wed, 12 Jul 2023 12:07:05 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 12:07:05 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        linux-edac@vger.kernel.org (open list:RAS INFRASTRUCTURE),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] drivers: fix parameter check in create_debugfs_nodes()
Date:   Wed, 12 Jul 2023 20:06:58 +0800
Message-Id: <20230712120658.14032-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TYZPR06MB6499:EE_
X-MS-Office365-Filtering-Correlation-Id: 36df132e-311d-4c46-f4c5-08db82d08238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQX2M0C9aryPWPVrSOfgOKeyOwi3zB3GGacirFyQF38R7gXm0YJBArgPF+iu+yP3WEotgMxY8GCOBi1UZm44Y6ADfYNHcJqtC4/tFSw2imTxEKNzsIkxh5SU7ozyhd+76XDRnmgDlg7dsf7aoZbRGMnnkZUQiKSuHyAJZDeXJGiWDEwKKnluuLOIyFOZJT9+LUI4c6/l+Gft9Qan8KQDpVhCC8V4S4QTSllsOs6lIJEGJO+edilDhBR6LR5dqfQ6k7ONyFnoQ5QL00vMMEjvuXVbWCp9WiRrZJfZUwt7Gln8jFiL0VIp6QlhKaQNJ7zckv0to8Nj/4CfJTzNIEsjACUqzYvMZ/Es+nYUg8tT5dB39TWnLFcFvYJMc0YX4NJBIC2b60k/y8z0w8CbjH5QkLhohRvfp1ksysRus+ekxzx/Rri2Oobw4Dg1x/YFBUa7bBGrORcxo7Y4WGdv2XpD7wrd56yGTKEHi3B9kyGHr8HJAtaYlRxlAz6PRvY33aoRuOzg+YW2zFHu01hwEU6uLyebCcwJKx1ZC3FEX7WLddU9adXRIHBI1f5H8+XC+Ma6fZ5J1U7ii0eTks+QUeYkzKCI29BFsQc1Om0iaAC0qGwOvA8IcIYTW94mpSZyOtVm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(376002)(346002)(366004)(136003)(451199021)(52116002)(6486002)(478600001)(6666004)(110136005)(2616005)(83380400001)(36756003)(86362001)(4744005)(2906002)(186003)(26005)(6506007)(1076003)(107886003)(6512007)(38350700002)(38100700002)(66946007)(4326008)(66476007)(66556008)(316002)(41300700001)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ILiygHXvW/4OnAdjWmrUX0EHv7XpuWMVo8kq/Q7UcvwRXWC2boBaXr37x7Oi?=
 =?us-ascii?Q?iZfaOH584r9IJtdH1WuqouBq63axH5IV9rU7/S7dcypmYOhXxTpY7VxVqU13?=
 =?us-ascii?Q?E58RSYnioPycSjrDRA3gRz1L9w1ertEv1rL+nftD9TEBiGixZLxn5qp+14fn?=
 =?us-ascii?Q?1HHsCiLSACNifuUsgnEDnmSUDDPZVdaAj00tpIKD5k8xORO+bX+1NtwSO/X3?=
 =?us-ascii?Q?tfagA1KKIPlttG0ooaUGfp8+H723VV/DXjvA9fhdqyEkRCmt/3QeXAgHG69y?=
 =?us-ascii?Q?K44wNcwjP+eA12dp1pk9/aU7qe53CPGgwqCbx+JcYZok0Q+I4MvZNQCRdLko?=
 =?us-ascii?Q?zzVhMG29v9aR/7TQYyVRNRWaa7gBA7ovpVY0BNRs6OUpTckGrsxexzUEFx0w?=
 =?us-ascii?Q?Nwk0l5FjI/0s2MoaLErrd5jWgS/CgFb7yTOE528G2MR14slmfvNkX8zN6Erk?=
 =?us-ascii?Q?xBzlG+zzxt5bxEjVYMUTozB6ra8PlTE0F6VA8qYHeK3rBQFYBq9fp9LS9MCV?=
 =?us-ascii?Q?YRjklMlVPrtDkgzWeIDoB4p0Kti54Qb3qqN38+SAWyFy0WvJXCAA44UQsuL7?=
 =?us-ascii?Q?obEQaJsNGlFZ6ixr8iG339Y3RQ363bUo100okl6ACjCI0In7IKYtXMh//IxD?=
 =?us-ascii?Q?+dEvAOkkBnl4d85L+Ftu+zy/QulRvk9OPm0+ZvkywMIgrFLujb3AIrTN6/FZ?=
 =?us-ascii?Q?Zk31IkYjI2E4gAQJo3VM9nrRVYuJ9pyxE99pjwoNRtr9nkhDUM+Yx8XijXEv?=
 =?us-ascii?Q?Cp67uvpSsv8aflqV+B03TEA3qRnrcHWif4qAXfBtMPLXxqc1JTTdaBSBFLtq?=
 =?us-ascii?Q?BYnYyaz2BLs9S9XZr5sKHm+eSzGmftZeLEo1UDXASa/KHTkN/Th0D73sej6t?=
 =?us-ascii?Q?ebfoN1rg+c7k+E8/DUIYXrbMv+gFWKkxWS13bpkm7ER/hv/8sC26MWpmF3G5?=
 =?us-ascii?Q?y08gpHLkpfd2lsmcrIJqjH6FTNYg/monwBA622/aRGMHQxDmH+nEZ5J+m+AA?=
 =?us-ascii?Q?MVbIhooMJkmH2K2+rDu2kCeT+3COQ65cgTSPFTRddpU0IF52ocS81mO9huO1?=
 =?us-ascii?Q?QetUXSbSnBpkTihGRKBisaO2Q3SRSV0cPaVK1E90Ys8NBPeE6cBp96BQvd86?=
 =?us-ascii?Q?nyAMr2PQh5wEx9uonHnap5+6f9BL5YKs30XFbJdV42iGdNIuTIQox1HLLlhL?=
 =?us-ascii?Q?IRhB1qG15/UKlFW/P+Xvu66NIcbJCzTWbbr+aGPNWunLPASdFow4nQ+12qc0?=
 =?us-ascii?Q?0MS4OVng6An3vP0+pslNFtexwHZaCIkhjK5lRHeIOUZZM2p2qMaeGirRJPqg?=
 =?us-ascii?Q?Uma3pObLjW3zWQir7cAK3g5mI8WcajBA8Gfn3zhSgOG58oPtPBtYQ4hyq/nU?=
 =?us-ascii?Q?WZIHl4js8ALgS2ekk/UaKy1/6Fv/Gs1OWXmUI9G0nwkulZL+hvQoWyEkQCP0?=
 =?us-ascii?Q?+rR/WufvzYoMlM2y40pZh+hNd9eZCto2c1ebylkDY2rYw+KAsDbp4q4/H/7N?=
 =?us-ascii?Q?TQqyfeB6BCBEt7eSKHCfjL1DxWqnBG+f32hF9qwMtXNFqsSjGXF3g07l1R8n?=
 =?us-ascii?Q?rR1jPUAZCElBzWX9jp9ebNWkRAv8F1h/CCJDd+09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36df132e-311d-4c46-f4c5-08db82d08238
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 12:07:05.4726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwtpBFJLvIFfKIbdy4mEu3w5bbAo7HxJiBqzR6EXE0HJQSjGayt/SfCJJJL4SPR5Buo02+kBzYFksXOip+L0Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6499
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Make IS_ERR() judge the debugfs_create_dir() function return
in create_debugfs_nodes()

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/ras/cec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 321af498e..27db1ae9f 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -483,7 +483,7 @@ static int __init create_debugfs_nodes(void)
 	struct dentry *d, *pfn, *decay, *count, *array;
 
 	d = debugfs_create_dir("cec", ras_debugfs_dir);
-	if (!d) {
+	if (IS_ERR(d)) {
 		pr_warn("Error creating cec debugfs node!\n");
 		return -1;
 	}
-- 
2.39.0

