Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D166B510E60
	for <lists+linux-edac@lfdr.de>; Wed, 27 Apr 2022 04:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiD0Bz6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Apr 2022 21:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbiD0Bz6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 26 Apr 2022 21:55:58 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1794712A90;
        Tue, 26 Apr 2022 18:52:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0t623aEiroS8m3FlOWsr0hzEBEZMjaX78o0uwLpS4M+KsC4qScy3m7jBweFQLaR8d3Fmwbg+ZM1e2rDGjJFh9eicPL2hyGdoOdUQEr8KRrntZX4n4S7QnXLNYcFe+NmqH1lRsySKgjbsUi4AocJFu88UyERaoGOiLpxZQ/dw8Zf/6JP6dV1ik2oLfJumxJHv4LeelLZ+SZUNSmMicVkxYoPlieChU9ctgbZ49axaA3J8dZuSObT2d7VYo2hHFlHmjykgCijOpcpA20IUVYhIcINPKmb8XVG3rhGbON/iA4/JR6APORWCoszpejCKLRAPGaUdW+GWBIsSkEQ0GVBRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxanjDe5IFpB8yyg6ZLFfb94x5Ftowg/aQq7V9hYeQ8=;
 b=ey+hfDOWYhEv53kF3vd7bB0Pr3VNhjXmJ8FZL/6durYxHgwp4snoOY+lyoLR3hBM8vIcPndOcvE9IwmtEYUa13OJZv+lFU26xMPGPkyniJsA/9Wal0mqYwocml4/AtqgolJ+WuZxmeT6eKM2W4sacNVjB38uxEn/XA1329eKy99J+bgM54eUvTpXYhLy/HEYIIlH9dnyJzdyZWNEhi9L5VxmFT1FSbAVue/0lK9t3aGUR1pqFVkRfhZi1eCMs+TNjAJAOx3HLSaRRKEfIwLwE66VFilZuwuEO5gABGBXy1GBdQOGya2AGUs+zbOF7/4d8C9irWPP5Yci3J5Hxik+Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxanjDe5IFpB8yyg6ZLFfb94x5Ftowg/aQq7V9hYeQ8=;
 b=anqtZJCOuCO37dn4uLNfVMZQlhzEMXoBzCW4jk8MFFe99RbYG0B/j986a2pSx7bSUSdVgPdWNrj5rMzg9WnBKYtV9gGAUC7DX/90FBYCn+/tm+5OAae6mGNGiVjuH342LYkj6cf4d+nq0LH+ZWNaUIGa/Ga5jYsax7puQ/vU6UA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by VI1PR0401MB2589.eurprd04.prod.outlook.com (2603:10a6:800:4f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 27 Apr
 2022 01:52:40 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1cff:564b:c3cf:46e6]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1cff:564b:c3cf:46e6%5]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 01:52:39 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     bp@alien8.de, michal.simek@xilinx.com,
        Shubhrajyoti.datta@xilinx.com, dinguyen@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V4 0/2] EDAC: synopsys: fix some bugs in v3.x Synopsys EDAC DDR driver
Date:   Wed, 27 Apr 2022 09:51:35 +0800
Message-Id: <20220427015137.8406-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00ff4ffd-749a-49a3-6886-08da27f09c53
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2589:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0401MB25892B576971B8880BFE62BE92FA9@VI1PR0401MB2589.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y5ATC5LujRXOaJK8L6oKJ6+Sx2uSB/oYx708pYexr2XllocQfkPpRUX8mxY1Op/hO1S7b4aaPQxz31thHwSfRMC2/1uJTK58gtvMYU+okA2oGsFtZON7wwc/0fkt1cXsrtOAKpILMKt2gEKa6H/O9JJm+ulBnENsuGtVjPma5WFQbwSQi2ZuDfMX7QXPN/NgvaG/T6HnOaquvcxMfeXfX+cqRbgrOuAj94gpjeGY9ZZKe1zLY72/cJq403dj9MRFT/2Yeka77Gyu0KVab5cVeD+XOuxqWyn7x5Jlxxso4P4kcsY1SClpYonY+Ajd54AkqccdVXnXECG1WTiMHuthVv3feZ1aroQ935dKtqWT8XseyWAV2h/aPtEmRVFvQhEaviJ/nU7XZ3cW3gAYKb2hAfbBlVIbJYefm+0uvK8RW1Up3lU4C7YL81vQhHBHKwO0S9b0o7iXU0hosJGv45GeTyo3/eRS1a9GFs0uMdc5mCtd6WRxGU8+qmBohWfReMzOFD0A+OUMk7dmwxfT9HwvNGwtjGF3QxMDgDxVCazII/BEX/NtWdYJQ0lDAxQxWY1sKH0lZ/04wA4UnpmoCRYJ5/75DverGLwcE0xhGv5NATGIvZPIoXonsr1QWZfjMELnH0+Y1XPn0pbtvYS0KP3BmD0A2Tj6ZT36b4K5xjwx6IYdjuAc+P/YqiWPmGzIN538wrMUVC3S5abnGAcSwkRU4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(2906002)(6486002)(508600001)(4744005)(38100700002)(66556008)(66946007)(8676002)(4326008)(66476007)(86362001)(8936002)(44832011)(316002)(5660300002)(26005)(6512007)(83380400001)(2616005)(36756003)(186003)(6506007)(1076003)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QbHjcgbXz8XSkFuP5J9qdluyOWqb0xgIXggU7UHfg3gNxNlG/H3XklsKPf89?=
 =?us-ascii?Q?6BJUfs6DcVSJ3/hevHECOrpoBGltDQKDMgQp9mwSFnUVgUAcqu67pQBk3SQC?=
 =?us-ascii?Q?31rXmRGdVIBNl5R7d2fv39eF/p+fflZWBBffXyMMCCf6aRUpn4q8Z+DIcUbf?=
 =?us-ascii?Q?OtLEq5mRbFD7jWftXUQmDtfW80vjJEAr3eKbAGI3CKzhBEPOBjgwulneHUw1?=
 =?us-ascii?Q?ym3F8lbVem9xJhkhMZIoITdhtsLeH+Hx5hPvFFvGSZZ96H0G0g792wurTXRM?=
 =?us-ascii?Q?8DLRRGNfSZdYlge/S38gunMX4GDgEeSFIO01NI/vWRB4iHv0rrTiTy2a5/8W?=
 =?us-ascii?Q?CNG6MQiNj6T72PdRySM/vc/3rBS7JIxSIn0Vc3uzWpVtGSKSOrnTamOYpf8Q?=
 =?us-ascii?Q?udL4VfBFDs2XjjnVijk4w5qs/bW2xFgFXg+g94lKtwMq8hRqb9zGauwXAqbM?=
 =?us-ascii?Q?lEJZvMWJ/VkxAx1mtW6eL+6tTKATz/e9rMAMFtGb8BQAK5bl+ysq3LttAmml?=
 =?us-ascii?Q?DohQlucIgmdHRki90k6SJoJbfiVNst0Jx/kDlCxyWlFCfalwdRWzW/Ev6lVg?=
 =?us-ascii?Q?WnaUOgD5vx1caA2T/6/N1HhBn7slBzR9sx6UBjKA9ac1gIhojz8BZV6pJ+pm?=
 =?us-ascii?Q?9HHANmOdST0/Ar/CHdgbb1sFDNeBP6TQjRZOqk2pQqp6dhqGaQH/+/6BA/VE?=
 =?us-ascii?Q?c+Cg2hcaRpHLImVcmJ17sgIGtsrAl8OCoK+ZYKn8Q8iyMKd8KuAVtB3pwmYV?=
 =?us-ascii?Q?QSXFpkV0O+9sf+IzH8ysMARgGEwzcqGOHu7O/LIqm0oKNn/qtFAuMOyRG0Ro?=
 =?us-ascii?Q?XJuCmdihCgvgvuThcCklHyJu8DgtLCejCjL8lTJLHEze+8cxdB7RvcuV+GUz?=
 =?us-ascii?Q?gp0aLGrbea9g6xqU0OhrxxTVuP7cvSj8nkwTBdAM8qCKj3knw6qgs5VkH7wa?=
 =?us-ascii?Q?T8bibw78iywVLcI7w/nNi3HGzczF6+xiul8vLFgIvv+DxWG0kOFr0uz/VwXc?=
 =?us-ascii?Q?6RpdVmq6nBUUFuacxyEzar4ND9cUm3ydGDsZDwsS+E9DwNKkUySjVO6dQkw4?=
 =?us-ascii?Q?ybc7s8guIT0Jc2vv0RDcDIp0U8YhVwmRwiwTIYVhVbUnA68UP6YCNmDHqeGp?=
 =?us-ascii?Q?PQ8me6b1bQWFnz1vzvomH8jkQBeaO7xDRg5Gth0FwUSNZKnHtofLFzBgh/pc?=
 =?us-ascii?Q?8uneviADVyOKwAYYwJZO1drRQ12pwmxF/0PQVhe/9rpPe5NdqxonqkbNuKpn?=
 =?us-ascii?Q?ziMY0N+URhvXmh6ZmPLexInuisH/jP2N0m04ZBOhwe7YacSigG7CUzmfXFBy?=
 =?us-ascii?Q?WjHZfiK9wWe3uHWoUYeyjYn+ecshvH4J3HkKZOHgEK7HiwJaJvQdPQLWa26b?=
 =?us-ascii?Q?FnGFT/2JOtPIEsUoMZpHa9FvNnX7s/pPc6HeD/Zdelsmb0DLht2ozFXjFqz6?=
 =?us-ascii?Q?niczxASSpcFN0Y7L7RmrvHGBSFRn7u7aQxkh69VtFKuZS4qRpc1PkQxrmyuc?=
 =?us-ascii?Q?nJuCkegx+/L9jrTZ+ExDmnU2Hd6uMz8EVGsoOJBuW+N6hHb6yiH+xMvj7xp2?=
 =?us-ascii?Q?T2TatBE0PAH6GDS1r+5n4GmRP0mHo4Rqkxv4SyxTFyNedo4hgnwMIL+1QaP4?=
 =?us-ascii?Q?uZC5sXcd+58aTNmqXRa2S/7lhNefcWGX71sLDHKpyGUUMs7QlR4EFizNilah?=
 =?us-ascii?Q?5lBnE+5HuwCPMLmDTOqfagejjnCIum0cOBENYLk6MPGLcBWaowQByUQfyBmI?=
 =?us-ascii?Q?3v5V5EwbxA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ff4ffd-749a-49a3-6886-08da27f09c53
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 01:52:39.8335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0sv6IG6MIxf9iBSVWptxzHROpddTfbGBodwODfDMoSHLWcRH4YYLfYwqS3jjisX+BFYQG0F9BeVFYL6UDBzuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2589
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The two patches fix some issues for v3.x Synopsys EDAC DDR in synopsys_edac.c.
For the details, please check the patch commit log. This has been verified on
i.MX8MP platform.

Sherry Sun (2):
  EDAC/synopsys: Disable the error interrupt on Synopsys EDAC v3.x
    hardware
  EDAC/synopsys: Re-enable the interrupts in intr_handler for v3.x
    Synopsys EDAC DDR

 drivers/edac/synopsys_edac.c | 44 ++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 19 deletions(-)

-- 
2.17.1

