Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9BA746F3F
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jul 2023 12:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjGDK6u (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jul 2023 06:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjGDK6t (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Jul 2023 06:58:49 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56180E6E;
        Tue,  4 Jul 2023 03:58:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnsJX+vshpm0FEnJdcP0mlHUz0eOcRpZEZHAXjPVOLgTTcd69nJZNSOy+BTb50vIksSa43HDFbPxG63lpvfcVnB+Ne8cmxsTyqVY3b3VQmRn9B2yYz8BoQeAbHNgoWphEh4PxHKS2DIL8fE0mOtCGcKxX3JEXlHryXLi6SqU75an6aGathPSQPM9SEX4IYuPQUwWPyQ+iJEP29Z4lWPiLCkP+5CvxiK7KSGO7+qZFFWjVvsZpyhjaSpkd/iGu13gy+cIa9EkF1ZnwWUozPH3WdoTStTePGJe3uBjDm4Z1vss5s7mlv/m/xTv8QsggRWFIrtiid1J26CULOO1XeXcTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yEEvMhtQXhsaKUdD3skytTWjMyyknF/BN2fef7zQi0=;
 b=F0jjdR24+wfPToBVcTUgXuf/xZ7fUbxM1JRWUVbW/jiDdWxQkWmnEbLbEsuDF5fx71zBCIHS/UF72zjbgCldY7MQVZLeTeXnfxDrirhrtwXoQFWinMQGtpDadL/l5zlodmuVe98yvYln+za3W7YBSRzVJmSVBLp3MuH75ChAIIsafVhTeiYv8hudrtF7KiFM45aZgPervUxdKeyZPLl8ryfwKtPfqqoRT8at86lq2gvWz0qwVnflw0qbBBjDVQvw2Mdbey5Mc+SMKykBW3I6tttmIdC3GSIYW9fN3aOSyLuxtUbI6KneKnXedaGvYzJAuVenpLJNjpNFIBD/nP4dyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yEEvMhtQXhsaKUdD3skytTWjMyyknF/BN2fef7zQi0=;
 b=ydbW8rDJY7sC96Y+xC2F0DYc9Bhi2hWwvXnpO8ILna0qyfg3K6p4D6TX8V742549/TGwkGWCkf9DhoWsNjzz6zGkqASaAOaO73WCBrVPMacmOYqG8s3insF7pJRfXGcoGo3IWrA2XrcDbUUeZS/Hs17fFNlLKR43sGNcTSuMf6s=
Received: from DS7PR05CA0024.namprd05.prod.outlook.com (2603:10b6:5:3b9::29)
 by MN2PR12MB4565.namprd12.prod.outlook.com (2603:10b6:208:26b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 10:58:46 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::ed) by DS7PR05CA0024.outlook.office365.com
 (2603:10b6:5:3b9::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Tue, 4 Jul 2023 10:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.44 via Frontend Transport; Tue, 4 Jul 2023 10:58:46 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 4 Jul
 2023 05:58:43 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mchehab@kernel.org>,
        <bp@alien8.de>, Muralidhara M K <muralidhara.mk@amd.com>,
        Gupta Akshay <akshay.gupta@amd.com>
Subject: [PATCH 1/3] rasdaemon: Decode bank_type based on InstanceIdHi in MCA_IPID.
Date:   Tue, 4 Jul 2023 10:58:21 +0000
Message-ID: <20230704105823.3516889-2-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230704105823.3516889-1-muralimk@amd.com>
References: <20230704105823.3516889-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|MN2PR12MB4565:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d8f5bad-fb66-49b7-d132-08db7c7da3bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1nWWAbB/001XtcluvDhWck71Wyo8DnENCLGpXJEtgJkqN25izHCjlKYGgJ8DD0WPEfOB4cAjmQcnQR76pZ6okYm3Q6qmtUtfT7TXAzYCztkaBkfBX/ahIktnBsQUZZKprCrLG5fNwcjn7Ei/zTp2ohFj3B4NviUe9lVdVZ5Qpyr4JNbbAYjOBspGiG3NQUnmZjHlL4awLnztEzyDufEug4SFrkSpeFn7iutl1ecJ9ndom9EVLJ7QKvIJo9BA1B1giE4Y2KjXQC1ARIzazB0slJ/qtVaqZIfuCAChcBzlM9dQRQXit828JM5qhdlcQF1qcVmaoq0RhMgffNo1lkppnrsiKofQ+dw0DohD7XAE5ZzWQwp8z+TrQihzkTdpdlSmr2m8Sj5K2js/ZXnMRbcAQ11Z7WDfgRv0nhOaP83SuPmUpvJj8RYfBLj1pPW/VPgMItk6PN9pU63VZzY1EETprs67bXg96ZtAF45al8d2GWTYRbd2lNfy2DVkxhkw12BQyh1v2YzUemiVu8/fW4pCA7c5ak3igZXZCvjRQXvamVrWvQifeVDGmtdJdjMMuMEjkpSbJot9RJIt2lGjGqjv7zbPX4tcnrwYKZpNUq7YgNsH0iD+wVzvjQr9i/4y0M1MSj+3Qo1BW60n54HyKDxkLhGZdAooAT5kHnSI+PUXQzbu0yYDNIWg683FDpyRMZPu6QvCAnSmxT2M0hl9eaWiHyukQl99cyO0vdWIoC1GxoXf/oFdy3XxFNBLzXaAU+Rw+I0AjeS3gTPiR0vH8aYdiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(6029001)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(1076003)(82740400003)(356005)(81166007)(40460700003)(316002)(4326008)(70586007)(70206006)(6916009)(36860700001)(2616005)(47076005)(82310400005)(83380400001)(336012)(426003)(186003)(26005)(16526019)(478600001)(54906003)(2906002)(15650500001)(8936002)(8676002)(36756003)(5660300002)(7696005)(6666004)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 10:58:46.2158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8f5bad-fb66-49b7-d132-08db7c7da3bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4565
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

On some AMD systems, InstanceIdHi bits b'47:44 of MCA_IPID register
are Reserved, but the same bits are defined on viz. Genoa. So bank type
is erroneously decoded.

Incorrect bank_type which is socket_id value is observed from the
register InstanceIdHi field.
Handle these bit fields appropriately to get correct bank_type.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Tested-by: Gupta Akshay <akshay.gupta@amd.com>
---
 mce-amd-smca.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mce-amd-smca.c b/mce-amd-smca.c
index f69b555..4a2e645 100644
--- a/mce-amd-smca.c
+++ b/mce-amd-smca.c
@@ -790,6 +790,10 @@ static void decode_smca_error(struct mce_event *e, struct mce_priv* m)
 	const struct smca_hwid *s_hwid;
 	uint32_t mcatype_hwid = EXTRACT(e->ipid, 32, 63);
 	uint8_t mcatype_instancehi = EXTRACT(e->ipid, 44, 47);
+	/* MCA_IPID[43:32] HardwareID of IP associated with MCA bank */
+	uint16_t ipid_hwid = EXTRACT(e->ipid, 32, 43);
+	/* MCA_IPID[63:48] McaType of the MCA bank within the IP */
+	uint16_t ipid_mcatype = EXTRACT(e->ipid, 48, 63);
 	unsigned int csrow = -1, channel = -1;
 	unsigned int i;
 
@@ -800,6 +804,11 @@ static void decode_smca_error(struct mce_event *e, struct mce_priv* m)
 		if (mcatype_hwid == s_hwid->mcatype_hwid) {
 			bank_type = s_hwid->bank_type;
 			break;
+		} else if ((mcatype_instancehi == e->socketid) &&
+			(ipid_hwid == EXTRACT(s_hwid->mcatype_hwid, 0, 11)) &&
+			(ipid_mcatype == EXTRACT(s_hwid->mcatype_hwid, 16, 31))) {
+			bank_type = s_hwid->bank_type;
+			break;
 		}
 		if (mcatype_instancehi >= NONCPU_NODE_INDEX)
 			bank_type = SMCA_UMC_V2;
-- 
2.25.1

