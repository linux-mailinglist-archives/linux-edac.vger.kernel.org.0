Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91ED65550DE
	for <lists+linux-edac@lfdr.de>; Wed, 22 Jun 2022 18:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358717AbiFVQIR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Jun 2022 12:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358136AbiFVQIQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 22 Jun 2022 12:08:16 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA3F33893;
        Wed, 22 Jun 2022 09:08:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U68zC+8/NMeeTMtEhYIPIhZLIlHkjNLv7QKYPR/0WVEF9T1uw5xXHw0EEKxhLrYFxbBAGUwMpFDYcppX4zyUq9Wo8X41xRoFFPbejFOYi9h1wz0/7scbVRjBE6mnW9eivdFy7SadVan+caXRbULNdurCVZajTskCuYby/GKk58ruf4hT+Nrrh9IbY2vDjPQdU0JApFtJDGQgYUIjkpSsckl/I/ZhkIMpNOtlpFvnhd1hlvaO5lyAKo8xyDGAeSft+N2fbitBygisKlePFuOI1fROYCMU5IHMgAZpDZDfj+K8CgVVxnvfE4kAhHByiFkn/f6zuJtqYx5tCM/WVomrVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qoQaDuP9xnBx+eB6zqSokieniYNGR+WR132WaiGrOk=;
 b=Rx0EpRvA7zCTGiSygs/DQx1WJ4ZBY3xeLzMiaLshb/ZHcEsTIwaSxECFMVrFNqNtkrJXpTUOwYxPgnkG4jHFNt8KX5DHG1UHkEaxxhBaLT1OR2/ZnAzyFWShUN49nDDLBNoJPYSMxgI8oennrL7/es6uFghrHWNHbQMaVQ4YeFHK5P/P7aSRD2I5+42+TdZ3bStn/LNeBY/dz3bdBzWZ4SYW03CEmXzYkRsm9KZIcuEQqNUToR5Bgoq+5DfitoPl23bAhHvwP2RifxBMXTAo6nGNmNiW+7JRWL7iDnlL5sgmgRLAnNwGWi/oCWBTRGdEYKG96IsLOCk7gmLevmdAiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qoQaDuP9xnBx+eB6zqSokieniYNGR+WR132WaiGrOk=;
 b=lo1oWlTMuDj7QTCOlM7u/qrEbAGXBZGBh3rKbUIC7Rv+FtKUGrlujQdMADPOWJdFVeZaCV1rtAK+i6MjH9yJO2RtRTMs1NJvZgghwxu2GLniGbeU85bq0Uackbvl1BZbDPzxj08e2/UlqVkL44y06zp0b7QVKrSLzNXPyuzTt8w=
Received: from MW4PR04CA0312.namprd04.prod.outlook.com (2603:10b6:303:82::17)
 by CY4PR12MB1528.namprd12.prod.outlook.com (2603:10b6:910:6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Wed, 22 Jun
 2022 16:08:13 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::e4) by MW4PR04CA0312.outlook.office365.com
 (2603:10b6:303:82::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Wed, 22 Jun 2022 16:08:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 22 Jun 2022 16:08:12 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 11:08:11 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH] EDAC/amd64: Include MCA error codes in EDAC message
Date:   Wed, 22 Jun 2022 16:08:00 +0000
Message-ID: <20220622160800.1293328-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bd9464a-1151-4413-b8ee-08da54696841
X-MS-TrafficTypeDiagnostic: CY4PR12MB1528:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB15282E639E5B8484D01C5CA3F8B29@CY4PR12MB1528.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PxGmo3VARlrTgnweqFM/v+I5lRufWjD12NgDKdFdh2+REKaDZjsZvR2VksauBbfJrJi7lZVEufovJv7IR0/oTclWBniIKEMWha5XjWQXbgFLKVtG+HHorj0iRAkaZ4r6FGGirMys2qFhwS9ZtaFB4TQdRnuz8wFaJdzAsgCsH9+nRpId+5oYrjdbsCShx+HaobzsTGb4iuT6SJtr5vymrUcXCrgwTR2sBnLM0wNI+19JPUgFJBvGZsIiNvKb7a7lyXhorTxhaNwiOOQijz+DeJxxzM0TVexOvSN9jrTMK1xgBqt4iH93qZz9S4Mw5uInmREu7a7l9V89J9yondxZf06JuJbg7/zpif3O5ikbnDH8Lywx1xghWhcxtXRGg6fA+Cu8IR0zvbghEhr8wv0BAq6SaN+cm4jNL4a6n+nmTzZdQHzEYbOYKmqx2wNdkjHmfZVvUaaR60rrjlylIUYT2B7muf93rRZ9bAjia3/jCxqFTcFhlnSTRYyKG2JdTEnlZBpf9INuzWU8yu9zAEWY/zy/gNfa/Tq7kZlSWG1VaWlJgVk5Y83IZXA4uFjt/9JQx3EfeGL4xVLilkNaXcgDNDLs+6vdfSSBqnJB8ZcalcifHEoFl70MgIsCsX5MAaH61aIFZMs0Vydvrd7woLQTCR/JlpMusTh1mOMEuu5x8dADdwbr6x7VrFVpvGMgMdSEylQn1fLiGGPK8WfNzD4ODukz3F37fQhXDZY/H1m/HreCLL269InTIkPARUavf014wiqNFm9Kl/herOWx8q8xy4/2XB65WDGVtqSKgEVZVWs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(39860400002)(136003)(36840700001)(40470700004)(46966006)(2906002)(70206006)(8936002)(7696005)(82310400005)(40480700001)(15650500001)(478600001)(54906003)(316002)(110136005)(5660300002)(82740400003)(47076005)(83380400001)(356005)(26005)(41300700001)(36756003)(40460700003)(44832011)(70586007)(86362001)(1076003)(16526019)(336012)(426003)(81166007)(8676002)(2616005)(4326008)(186003)(6666004)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 16:08:12.1752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd9464a-1151-4413-b8ee-08da54696841
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1528
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The AMD64 EDAC module does not include MCA information in its output.
Users and tooling that gather memory error information only from EDAC
will lose the MCA information.

Print the ErrorCode and ErrorCodeExt fields from MCA_STATUS as part of
the EDAC message, so that relevant memory error information is available
from a single source.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 11 ++++++++++-
 drivers/edac/amd64_edac.h |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2f854feeeb23..7905cfd34cd0 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3168,11 +3168,15 @@ static int get_channel_from_ecc_syndrome(struct mem_ctl_info *mci, u16 syndrome)
 	return map_err_sym_to_channel(err_sym, pvt->ecc_sym_sz);
 }
 
+#define MSG_SIZE		1024
+static char msg[MSG_SIZE];
+
 static void __log_ecc_error(struct mem_ctl_info *mci, struct err_info *err,
 			    u8 ecc_type)
 {
 	enum hw_event_mc_err_type err_type;
 	const char *string;
+	int len;
 
 	if (ecc_type == 2)
 		err_type = HW_EVENT_ERR_CORRECTED;
@@ -3209,10 +3213,12 @@ static void __log_ecc_error(struct mem_ctl_info *mci, struct err_info *err,
 		break;
 	}
 
+	len = snprintf(msg, MSG_SIZE, "err_code:0x%04x:0x%04x", err->xec, err->ec);
+
 	edac_mc_handle_error(err_type, mci, 1,
 			     err->page, err->offset, err->syndrome,
 			     err->csrow, err->channel, -1,
-			     string, "");
+			     string, msg);
 }
 
 static inline void decode_bus_error(int node_id, struct mce *m)
@@ -3281,6 +3287,9 @@ static void decode_umc_error(int node_id, struct mce *m)
 
 	memset(&err, 0, sizeof(err));
 
+	err.ec  = EC(m->status);
+	err.xec = XEC(m->status, 0x3f);
+
 	if (m->status & MCI_STATUS_DEFERRED)
 		ecc_type = 3;
 
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 38e5ad95d010..a49d797b7322 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -422,6 +422,8 @@ struct err_info {
 	struct mem_ctl_info *src_mci;
 	int csrow;
 	int channel;
+	u16 ec;
+	u16 xec;
 	u16 syndrome;
 	u32 page;
 	u32 offset;
-- 
2.25.1

