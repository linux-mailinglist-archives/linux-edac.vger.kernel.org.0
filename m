Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D69218B65
	for <lists+linux-edac@lfdr.de>; Wed,  8 Jul 2020 17:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbgGHPfb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 8 Jul 2020 11:35:31 -0400
Received: from mail-dm6nam12on2079.outbound.protection.outlook.com ([40.107.243.79]:29917
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730055AbgGHPfb (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 8 Jul 2020 11:35:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuBOU9QYv+CTmaIu+TpJX2LfbGD/mecfRqnxO8/InAPQuX4FJrx2H9FUfFqr0zZrPNdDQXic/CPM6GeRGzt3IeVKUgd1htJ6HSYMwi/XQ6M6DYWUEDKo21vTJPzU4JqNjKDCfiJgCrwreDMznDmCtfNHRArDNbiGhwLvh6/pjr1d1K8rkG1bI1tjFMvcOvRWtiJdO5oFY3dC/YcZgfxXkFFk7DEQnKsbrmvrJX9vLW2inZOslt+oTiAUjWHwtHJsRl1P2CrX+UxNoJW+E8yiIuoQQR9yOOtYpjRu7gOmcFEChWYxAy3Z7VfvWP3r19HUWZJFTsjTdIvU83OsyfVt8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8cLp9oF1at2VsfvNG/jxswobjC+wXuLkSr93oeRzVg=;
 b=Jpvhdf7rPIYnx4wx6mbkVE26woHJRZ9VlujwU8O3cnOLwvi/aR+NHSvI60mt8b4QBm6vvMHAXUaHxQMXfptg7x+M7bp0DpqxVGG8IaTnonqg8uN90ArOFTlvWW3PjF9ajezNNc0F+mmrf9Q82exb41CaufXjVlVjFAeaWWMg61LTq9Pm8FCBd1q7qXpRO5bNY/kuo50PwuCLiP4ZF6Xso01d46yZ2AOxNe6NYdl5KG4tbOf24ugRJhDilu9bBkhKJeWmZDScQuTrIVJdF0rWsdRmr3AwFCIPVH92at+lJ229v9HhMAWorhAa7ENtzEzV3o6smeWOaDJxpn8H959hrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8cLp9oF1at2VsfvNG/jxswobjC+wXuLkSr93oeRzVg=;
 b=kFwm8p9Y8zJrcKF1wLUBvJXzpnIjdiXt+lUq0OaWSDUPsnJ/NHmhPFlmrBGQRhOmrVjcarl0D+DgCWOsmKUdSLU/I3IsPuCa0M3z7bfF4zzs+VWCOU70WqqBF+5vYLdEwxz/aFf4Q/wba3Sf9GzfodXOUq+IhSHLnRfohEmoyr8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2882.namprd12.prod.outlook.com (2603:10b6:408:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Wed, 8 Jul
 2020 15:35:28 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::2c67:480d:4505:5314]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::2c67:480d:4505:5314%3]) with mapi id 15.20.3153.030; Wed, 8 Jul 2020
 15:35:28 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, bp@alien8.de
Subject: [PATCH] EDAC/mce_amd: Add new error descriptions for existing types
Date:   Wed,  8 Jul 2020 15:35:15 +0000
Message-Id: <20200708153515.1911642-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR21CA0016.namprd21.prod.outlook.com
 (2603:10b6:5:174::26) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ethanolx.amd.com (165.204.78.2) by DM6PR21CA0016.namprd21.prod.outlook.com (2603:10b6:5:174::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.5 via Frontend Transport; Wed, 8 Jul 2020 15:35:27 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5e90d974-06b1-43f5-acff-08d823548aa9
X-MS-TrafficTypeDiagnostic: BN8PR12MB2882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB2882F7AA947291B2A0938030F8670@BN8PR12MB2882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oHjusl6oIYfxI9GljfIANqavCN6yi0GxieM6PVKfKAhMrlI4EetsNBwfwNKO2C316LUuGSGfxqgMXgVQNGkGdlt7HJs8S1nmmU5vrgI7XCZlIfgvqgAXyFm835ZuNzHg8n4YOqV8rRN3RNupq2wVOInfyD/IJ+5J5PKPe3Wk7j6drDxrp5/0dd66XDf8YsmfUE4xi71YzEpvXTXjIcY80K/kf6kHVx2SP5Xdk7tL4Ygp54M71L04v/Kb2ZukpyakeaBj0Mh85MklXdXIbpr+PuA36XkFn/CNi1Ijzky2pSafaqE/dX60bA2MBHFfL+ZW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(956004)(5660300002)(2906002)(26005)(6666004)(36756003)(6486002)(86362001)(4326008)(52116002)(8676002)(7696005)(2616005)(316002)(478600001)(8936002)(16526019)(66556008)(6916009)(66946007)(66476007)(83380400001)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: J0+JsN0Sy++lAnkoUTCH8S5kGvqi6JVFmxSfol602Bsoqk9qCR4N7icTfzlJFfW0pBbREPWTUnO/a9FHZUldRgLptoqRb68OFtL6AUaIPFtddz1Q19OcudA2hpsOdL/RCnKAmEJY8SQdc+5ISEgOpbDan/NHOEmfmRKlizUq4fNpcxxZRSoCIok7LLpBPD4AHEYLMqvdvlaBcIokEQu/IGtGg+uNOyWSeCHcGShXbX/mnScZKTC/VnE62LoWH3Ddv83Axi0ajLRzZk/raWq3JUU1ujNbnloFC/dRSLCga3px6yUVQD7C7W8Lx5CM9ws0KISomdGuyAiCLNemLws9Ox14v43ql9dgcr7rElQFeDV4szNTTA/fpaA+kHLlOPe4qI95KyCFMZSPlM8pXWgvvagJtgbDSirlzvQxbuMCeWu9fwaOLG9CnnqbzrtPfcIrGPNc9xoSKFTQy2p77D8G+4GZxXNNYDK8isngSrws24w=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e90d974-06b1-43f5-acff-08d823548aa9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 15:35:28.5434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1aB0/kXVSGK6FF7AHfRYORKpNh/7djHNjzqAGPgHjt/enThc5XcFD0NnVAA73+dUsvqIw29k8tQYc9QShE+sRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2882
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

A few existing MCA bank types will have new error types in future SMCA
systems.

Add the descriptions for the new error types.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/mce_amd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 325aedf46ff2..4fd06a3dc6fe 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -210,6 +210,11 @@ static const char * const smca_if_mce_desc[] = {
 	"L2 BTB Multi-Match Error",
 	"L2 Cache Response Poison Error",
 	"System Read Data Error",
+	"Hardware Assertion Error",
+	"L1-TLB Multi-Hit",
+	"L2-TLB Multi-Hit",
+	"BSR Parity Error",
+	"CT MCE",
 };
 
 static const char * const smca_l2_mce_desc[] = {
@@ -228,7 +233,8 @@ static const char * const smca_de_mce_desc[] = {
 	"Fetch address FIFO parity error",
 	"Patch RAM data parity error",
 	"Patch RAM sequencer parity error",
-	"Micro-op buffer parity error"
+	"Micro-op buffer parity error",
+	"Hardware Assertion MCA Error",
 };
 
 static const char * const smca_ex_mce_desc[] = {
@@ -244,6 +250,8 @@ static const char * const smca_ex_mce_desc[] = {
 	"Scheduling queue parity error",
 	"Branch buffer queue parity error",
 	"Hardware Assertion error",
+	"Spec Map parity error",
+	"Retire Map parity error",
 };
 
 static const char * const smca_fp_mce_desc[] = {
@@ -360,6 +368,7 @@ static const char * const smca_smu2_mce_desc[] = {
 	"Instruction Tag Cache Bank A ECC or parity error",
 	"Instruction Tag Cache Bank B ECC or parity error",
 	"System Hub Read Buffer ECC or parity error",
+	"PHY RAM ECC error",
 };
 
 static const char * const smca_mp5_mce_desc[] = {
-- 
2.25.1

