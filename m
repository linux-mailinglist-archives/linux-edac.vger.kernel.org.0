Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6844DD8D7
	for <lists+linux-edac@lfdr.de>; Fri, 18 Mar 2022 12:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbiCRLVb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Mar 2022 07:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbiCRLVa (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 18 Mar 2022 07:21:30 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80077.outbound.protection.outlook.com [40.107.8.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669181F5196;
        Fri, 18 Mar 2022 04:20:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwvRfMzRdzxZglWeIEhyrY6e5KqZm6pGetxfUzU5EFAy9Id0GHQIoIXvqOmWQAmke9gVyPNn9SN5TSE84I/xeYtMxYNdQ2+NUCCj7UK3T/bt1QZ/5rZsxiYJSvHVkGZ+nMQRjDvdpkPIapP3UVSQAD55kvyLTFBTMGasQLhN7/cWkUnm4fBCfwyvWko3wPb1aF3xBpVTHzEfcDglugYxxcVvSwQN8YxITK9FZcZkzN62M1ZdQqGeNYm7W2269qJnkRVLWsP+4LEYfnwszFrp/WZPydsktMqr4HoS4aG+wxnqhM6nm+yJq7rBho5tN67OHw4jJ16eLeClnQqPC6+u0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laEAGPUJ1L8UiJ3Wsl54wlV9Ig3njOhaqGNLzy3ciG0=;
 b=XXjq/RM92LLnyywL6Qet1DQpc55v6RR63MsZ1Z9p8Y5iRjoIOpxZtMdEFhad6OpY3nVpBvLqrkH8blddDHFr8aEiuVp01DHecwqre1X/Gcxrxf0ebcIZk2BTiDV9BZ/ff9hZcxbzwmpEgDmheShJr48MIsqJQXIe5QEuJz3//1Igsfzekm+cqUSkbcs/gnsV6PGxkT/cznGYP2535YPsY/d9YS5vii2aLNa8Hphd1ZEytL7ozUuFXpgZSEpK7z4WNkBwMrOQSIMg8fOlC0km1BomnZDEV+GfshYRcymoYwtKasdm1ZsOg72b38HIcj59tqzGn3PgVVyDF5PJkB9eQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laEAGPUJ1L8UiJ3Wsl54wlV9Ig3njOhaqGNLzy3ciG0=;
 b=mFWUiBBIMi1Qp2ghop5JDCdgFhZOBQY6OIqf2QqxWVffbVhOeUXIj7Yr1EH7v7aT2j6xf3kpoKp7qi55edOoJConH+jU9IV8LvKPqFVYcI58oCfl3QuLzZ+hrpsaJdmYtl60OQ3OQePr99aTe5TNfJaeBYk2C23RPdxiPQ1Dhzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM0PR04MB7108.eurprd04.prod.outlook.com (2603:10a6:208:19e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 11:20:09 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557%5]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 11:20:09 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     bp@alien8.de, mchehab@kernel.org, michal.simek@xilinx.com,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH 0/2] fix some bugs in V3.X Synopsys EDAC DDR driver 
Date:   Fri, 18 Mar 2022 19:17:40 +0800
Message-Id: <20220318111742.15730-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0088.apcprd06.prod.outlook.com
 (2603:1096:3:14::14) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ca2c191-77aa-4ab6-21a6-08da08d14332
X-MS-TrafficTypeDiagnostic: AM0PR04MB7108:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB710821A880758B95FE429BE592139@AM0PR04MB7108.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m1eXrRyrbKLueUSp59v40NjuAdpQdsi2w/XIucb9ZakEcy3oBTEmeuvCsJStpXXrh+wnApypisFtkd6lGrcJVwICJ7pF6CxQPUusAzTQtG5iOxvr3tCzTQTY57/8k/FxB3sJZNQ61dcBbV3MH95lBBg0vA+wZFm1lUJFILWwjrgwAJNDb+IEchb4eMtOiMW1DaUhdW9VncAzlZd1joshxmrHoUb2CnwRC5F7AwMyup4zhhJXmhf2oGEzvIO+7fvi+bKjb4XnwjoHy9Cd6V6d0mbJr8u5D7Goykkow+9rpv2Jkdvh2mEJvWDfBi2GJ8e6d+tt/ob9XZ8+bv9Yo37E7BPsCvgD0xVEQ+RgMqTVkVUeRZfeQLWamV2/e6vl6w1O6YpCXW7TwWnAoJFNhzgTD0FndJ6Lbt2DFwXBPtzQFaHgcdt/KQJ+03uoFp9liz60DIQ8EItzqzjasNfCPqi7rJQyG4OY3GsJfAxMQSZez9yMwoNKcBVYQzRECxcaMQ+W5nRj6Y+wO/KWrw9vu53CUuyczaAqubLtxugSwZSb4/Taw494LXUNFZryIu8BByFmRB4B17Tjl0jq9yFFZ9ApGVQyYvc7D0Iru6JvETXjNJjFxkoaX9pLYx9kAgz/ZZ0G7bCm0j9P4xv2cw9qB/qTMI9LJsAj9sInD+kNBaRpixgQfxcIM00Iua178bven87DJCwdni4Wlbtft/5oflJJGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(4326008)(8676002)(66476007)(66556008)(66946007)(4744005)(6666004)(6512007)(44832011)(316002)(2906002)(4743002)(83380400001)(36756003)(2616005)(26005)(186003)(1076003)(38100700002)(38350700002)(86362001)(508600001)(5660300002)(52116002)(6506007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AplEviC9Zg5deQZMo+9zyvRL7g981cmr9GDngxvzew/jG9pCiHOH4J0yL+vD?=
 =?us-ascii?Q?7yUUmo++93TNPwFjecNgn+lPoUjRNLSkv/zi8al+hBZBWUL9Q1Ybh8yIYINX?=
 =?us-ascii?Q?V3Qpp7M01D+dlmbp5f0T5DIkZI9z2xYXhcx/QUnCtxXMttiMNZlmnT97FTbD?=
 =?us-ascii?Q?vjIdmSR8dYRrddzBvdnGzxQc6ciANnovqgKjlEWo02wPZR0Lp0DU1J4UBlMf?=
 =?us-ascii?Q?Q9yTHA90N7NRzIMiyJfO+Bp8+y1KQo4EjKZJCosB8DlwFEamefC29nLS7UMs?=
 =?us-ascii?Q?6tDIUggmL3bdTg1+cPzP5mOsRvUciqj3X6/xXsvZXGll5Fj3WRRCL8D2Wm/f?=
 =?us-ascii?Q?kImwK62Sx2uhd5vxLrLM/9rF5WxTTyAvL/955xMTg/8AMU127qyCIUGyQcH7?=
 =?us-ascii?Q?jHWOHo3dlbEbQlJ5JvpPgDACRu/NvD3gLzxZJf9Zg0OluUi1sBVQf4A8etfw?=
 =?us-ascii?Q?JHWkO4YW3lT9FyQyj5cfHEIZ3s2f358rDRCxAuZOeMzgqctxxZPip011b/KJ?=
 =?us-ascii?Q?TfSoXK4zMuN4HEchYfUZ8Bu/grRc9q6klxFJxZJnDmFp7sY8okbERgjuwLAW?=
 =?us-ascii?Q?QuuknTEt8xdzUHVo/xnE3L6+Kw9n/k5u3BAbt/jICOvykcgDBRcgtsFK9f12?=
 =?us-ascii?Q?3YxWvVipSwd+k0utVvXVbzOpl/PLXyzYKtws32ycxouui3V0KQlW39j11crT?=
 =?us-ascii?Q?JnTwf/JFxrRcxqJqrxETXOQwDZWdng/Z+dOfYe91nV/cUBXAa/yBr45wDMbW?=
 =?us-ascii?Q?uU2hxdvRwcELkfUqs/6MNX84MnXktrRJPlWl9dzkhZKjtBgfBLeDL85TlH7f?=
 =?us-ascii?Q?9T6O63CdfD3wiGuArMSV2+C9ZvsQ5xkuU2o2aU/ACVxOkJJfZl9gIJAtA1uq?=
 =?us-ascii?Q?+ZzAWHWwajBei5cMd3euXS9zFhjMC1lTgKmrqLovmFOBV0Kg6GudKL+Tgjrw?=
 =?us-ascii?Q?zhxd02NP+/jhfIjEerFgmAcLaZAc9/zLW3dkRIEM887LMQW2cJ/+l1yOiLMM?=
 =?us-ascii?Q?C6WZV2j6VDrOEnLHb7Q/wfISTiIZ4P3D3axCzgep9q8UoyULDq6Ta7moSM1s?=
 =?us-ascii?Q?9qGAhTmoLyg1pjo1ztV3P+IAIw1q3l1RHGuauk2z0PiUIhimL8LxyfQoTP7g?=
 =?us-ascii?Q?+mgmpgtCtUOo9wbRxbameDQ6tSquWj6KeIOym9yQg5APHEBqg0f7gWC6XU//?=
 =?us-ascii?Q?dHxHrT/3XdclR3/lBLxtaHyKEfEa4HptbSt4i8n5AD4ar9MtOgziKEnzHq/5?=
 =?us-ascii?Q?SmUpS0hukCVpypMKnMOBvEVbkxGzL9u1VigMr+a4qArr/96gIP9usoCzRM3n?=
 =?us-ascii?Q?ZbNpBuXomDGCUc4StiW3mtIZXtqoyVo0MFf8322inyRWPq+hGjKivpBOkxtV?=
 =?us-ascii?Q?9PXd4FF5qmIXcdPb0egA+S0L9XmV3qk4XOe6GVcD8HDECDUbG1mE9NGVOIK6?=
 =?us-ascii?Q?VSR+7J8pXsnfw83FC77Skm4ThZc8GErd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca2c191-77aa-4ab6-21a6-08da08d14332
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 11:20:09.8004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1b2bdLlOvP6SfoUP4dLMvo88sziBSXw8u0p5tnRqarqWZQpvk9fxxVRmxmEmOudXguQMHLpLA397KHvxVu2hEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7108
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

 drivers/edac/synopsys_edac.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.17.1

