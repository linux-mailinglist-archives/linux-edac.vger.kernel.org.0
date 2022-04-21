Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6337C5094D7
	for <lists+linux-edac@lfdr.de>; Thu, 21 Apr 2022 03:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383717AbiDUB7V (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Apr 2022 21:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357029AbiDUB7U (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Apr 2022 21:59:20 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2087.outbound.protection.outlook.com [40.107.104.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1066333;
        Wed, 20 Apr 2022 18:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUfxq91BvdtnnynEOcnSXOP9xnCdza97yJDHrFHEVUdrVsPyow9L5zZyzYU2ESWCS9gG4SLu5xffiEf+Wl1XE4TBnr8gfQTTJx7+NhRxrjHNTlnoRsAd86AS1HEceVXDawwmtbZpFYkINFOdJOkJok7dpQ6+PPQMuWDg4KCMRQD72VRWSc5nS4qh3V42rbLoFtvy8ar0hUIS0s3Y6Zy8UBA3dkEMakO5k68W9TbxKU1ZseIL14q+t+ODndboqoRJX83kfcWrnmTry3waiuxNCadUEwNE2ofGv6hrbiPgjr8M+MXNV3nRCfOn9h4H4LnYe/jOz7qy+GDFBp6cBoGQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XE1qcmGqPDj+7rzP3atxN2WbTpyefKyxpTQuwx02mUE=;
 b=I0B2mzUBEgAFTyjCLmoCSebHZtGPH8nzD9par0zGufuyIaGRxlKB/EbBuZnsaFq/h+4u8xoCWftUV9luW7ARTj6CdWqOMkeFcd9XYAEPB34/bUqIC5bS1RqUoqPdQPf8lO3t8EZ74PNyx9DV9xy9wwneXyxKmyBcqM9jt0ajFmvS9b8SBZDQHq3K6NYCIUJ80b+rfTjZ5EP628eZc4iRTu6NYvknJxeT56PKO4D/MycXVjqXTtsJbnOuTADKiDEgewxxeLh/07ljhR1zC9y9cR2W8yKMdy2biu+Gy8MIak/2VxvyYGc2rFv0qDZGuW48aaFoqwN0uF1XAFdtYn5tDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XE1qcmGqPDj+7rzP3atxN2WbTpyefKyxpTQuwx02mUE=;
 b=FcB2MdOwkwVAPv57CDz2nUmNfQ+ignKfB/xRqc/cdXbZqR15YJVi8Q0dryAuajhB7ibf52LR9wSQk7vvFVfRYrhBzt8DFCLOdkVYOA2QPCl4yMz3XOkJFAJ4+IExeDiqcSFnSzxDDo4Bg4WeoDWJ8VQdSkpZHVKbYjI8bvwrY9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DBBPR04MB7564.eurprd04.prod.outlook.com (2603:10a6:10:1f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 21 Apr
 2022 01:56:30 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::55a2:d9e8:2c99:1433]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::55a2:d9e8:2c99:1433%4]) with mapi id 15.20.5186.013; Thu, 21 Apr 2022
 01:56:29 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     michal.simek@xilinx.com, bp@alien8.de,
        Shubhrajyoti.datta@xilinx.com, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH V2 0/2] EDAC: synopsys: fix some bugs in V3.X Synopsys EDAC DDR driver
Date:   Thu, 21 Apr 2022 09:53:11 +0800
Message-Id: <20220421015313.5747-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1301086c-fb29-4ded-2006-08da233a26f6
X-MS-TrafficTypeDiagnostic: DBBPR04MB7564:EE_
X-Microsoft-Antispam-PRVS: <DBBPR04MB75644CFFC45F6AE310B03B1292F49@DBBPR04MB7564.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o/7DnGg8F4WAwEVSRSacz/OH/O1cih4S04bIbqf325aK1VteEgKoLa3pRvxEU0XBdtITVPg3c9Rzn2f4080WpGcW8RRQglUF8lfXAnZTYypNtLY9D21Xxd739SyzVgN+4C23+E2nrfCtGNuhF/mDVS00tkt4nDn/h3QMxLA2hlcpTBlEgfFnmOdrCoXtMTDofOkg9IF0kAHzWe/c4EDNm2D0hoAgMPQo3kIS8W4O+Jt/9Gpy96kxfc914HeALXCt8155Ff/k3PR+iEu61XFXC0ukqIauhuW7cck0qSBSQAcc7W4i7ew1cE6KxfmTy6IgM2rChiYA5z4qy06FlBqVPy0jEofL4Pr8Zt1BRtFsBH+HHUAECDcolq2y9alg/EzMctYZd5HhIEWOqK+TftD+THwHGsrUea0iVyfn6KtE4boeYHbhV4zMQs+NeKzAQP1LW0HL7EOH86P2WN4nUCSJEtqzGoEWM62/xA4JbtKsnF14jiiQ7S2gAntLgUjAThp3Wb1eV5hSKkxJqzcJML1WVFsjmtnSwSK/VPBNVwiNtuNV3lDNQ6jmyQvbwtmn8o97hrg/WsUPzOQUNsXUbW4ygrSX9b3yO4fGr40rfQTq3cDZ6c3SpSpMPQEJP8lL64tqcNJF+hf49VSf76tkUHIhJ/7iMG3vRYegpdf/um/7HD3kPgO/h0JX0eoGhh3gEhIVGgrKzQUIq1CX4ExuTTRiYx4wtCr4QWB4uMyjBaBUxh0LD+Mwuj69yJ6lU6P+Nn3j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(7416002)(38100700002)(38350700002)(508600001)(8936002)(5660300002)(6486002)(316002)(52116002)(6506007)(4326008)(8676002)(66476007)(66556008)(66946007)(6666004)(186003)(36756003)(83380400001)(2906002)(2616005)(6512007)(26005)(44832011)(4744005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vW1xOOhOqyL2/eJl/KlOYcBnDKIMTGEhVSJRdPz+ouveVwahHgmcVyRz8Nm5?=
 =?us-ascii?Q?yJrWDKD7iJQ/ytImNbrFIPtyRC6FLLOGVm1tonxfHPX24J0FW7sugQGRIhtS?=
 =?us-ascii?Q?IxB4keHBMwoWw2HbZiRuNZ4Rw8nV5rbMzn/uNpLLV6anb1SgWKuGhb1/V52V?=
 =?us-ascii?Q?Wfruiwj1WOs+z9GTlat6oAYLHsZ6Bg1vuuyq9VX3vS6RyV4oE75SpnO8v0Mj?=
 =?us-ascii?Q?ekDoo4NknKw0o6IwrR82J8wPqHKt0pAhqKBhXug2ncepiaha8t3r4JoAH4zS?=
 =?us-ascii?Q?nwkDpyRs3IBWT7ioIDpEK0M2sXPO3HbsA8xNj4B2gbbaZLX0zZ5ChvoON1d4?=
 =?us-ascii?Q?mwvPwT1+XuYaMIIr18l5BuLZZyvSBF9hL71fXptlw1vFe4zN8xBD6COyK9Uk?=
 =?us-ascii?Q?egzKzfQMTMHquZYtlE0DZRPFtFdUe3iG+p2I45YKnjxEDiaORxDYiaWpPOTo?=
 =?us-ascii?Q?GiEDiLAwsDNGdoxN3353lOYi2VSS0yYOntRM7iCU9CNLANzFMbTGMLiqTFmw?=
 =?us-ascii?Q?2ojETrAqmKP01lyiZGL5YgG847djQbNZd0Y1+BPJlmJNoo2bpGq0sSVroX1B?=
 =?us-ascii?Q?PAhKhMH10jBntUUgO6Z5CioTXYzlzcZI8DpUJlSzTruEkSGzCNtqAjDcOVcV?=
 =?us-ascii?Q?PFOYNmS1f25bcr9iXiVszBSDu9RdRCHtj1jLZH9UR+R0ao3zooniNsT5tVod?=
 =?us-ascii?Q?R+hcls7E7AKn6CIZo8dUUhbU2N2fRfJpFXEMSZCki6jmsMOlWiiMuS1eqZhi?=
 =?us-ascii?Q?pHQjoByJNEKe3aJTBb3OvysdqPWWzPS4LLb/DAdtF0/Bxe46Wwd9tqxpgb1S?=
 =?us-ascii?Q?u3G9dEbCHzPQ5mPVCXC/L0TeMQuhe4tMSB86CG4HGxNIYizjR1TzX+yZYvSN?=
 =?us-ascii?Q?RDPWxqViuKzW2axtgoK3zhkEaXpToQgRbiGMfem8j4rYqvXHH01gHbfHGi/8?=
 =?us-ascii?Q?/Jm8021ZLoaG82RdJ5xwoLueGwObZeoy7LTnz/L7g65Sr33LgdQYy3wZuwii?=
 =?us-ascii?Q?ywf0E9RA7fPprb4TqUr4IZI4cEkS5ISFufLA6rGMDLyCfJeAs05XBRGYMqA1?=
 =?us-ascii?Q?aDs0gFUbwFQ9TVoJul78eDuuyZmhfEOeRWpv2a453fYIceQfIxsyo9JEx457?=
 =?us-ascii?Q?cvyhsjvxpCHCycQcEjO8y0QMAyUmhXEmY4DXlOYA72lSNKPi/84KbQtO96GX?=
 =?us-ascii?Q?hK5V8Li9whD7tBMhpDkNngAUfbK9wK8GYN386RgtZ56s8xXuWq94URlo1RoX?=
 =?us-ascii?Q?MC7Kti/tkVE5gyn6xfDThkEUBTXYDIUJL+I5zsQuB032YOZYxBxfI8thrPMF?=
 =?us-ascii?Q?nJAKIHvHLS8MdkOGAvYZUBcZIRU8it+0V9CnOXyxT2vu2snvtJvp0hTF6SRS?=
 =?us-ascii?Q?qHBB7qBtQSf4Hs7Yeuv5WtKYVhOOCAXsX3LZoPqkJWRCqeaPF9y7WducAQVo?=
 =?us-ascii?Q?ZqHqu8OxXGT6JtYRoBiOLbT7eS0LFrDcIt2RgJ3oHO3OceKKHNoHYdWaJqnF?=
 =?us-ascii?Q?s8GeOX8eeGL/cwUoCF8+7j/dR43J/ikJvxmrciml+ZIz64Pim6wv9obMAN0q?=
 =?us-ascii?Q?B4gKzTPBDYOalFA8THeLMzfMu0TtISYlA5bb5LVR4Isl9hjOOtaDkMCt22zD?=
 =?us-ascii?Q?yJ7MrGhqEbI1x1KSreUlm6s3NQiDKUxzjfjp538qiRZOjYTWY5AGnHuXJYWf?=
 =?us-ascii?Q?lnYAh3sPEsgXHvxj0znr+rq1EeacQ7WfKe97p0M/tUQIyZfSRQcSoal0ikO0?=
 =?us-ascii?Q?jmxBjdnHlg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1301086c-fb29-4ded-2006-08da233a26f6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 01:56:29.8210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1nQxVUB/rDOfU63FTiKJUuB0wrUNQXhB5YFnC13OyjiDJPJ4Mn+dMF8qgp9DglOTVZUzkg1ch+WpWPWFjAXZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7564
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The two patches fix some issues for V3.X Synopsys EDAC DDR in synopsys_edac.c.
For the details, please check the patch commit log. This has been verified on
i.MX8MP platform.

Sherry Sun (2):
  EDAC: synopsys: Add disable_intr support for V3.X Synopsys EDAC DDR
  EDAC: synopsys: re-enable the interrupts in intr_handler for V3.X
    Synopsys EDAC DDR

 drivers/edac/synopsys_edac.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.17.1

