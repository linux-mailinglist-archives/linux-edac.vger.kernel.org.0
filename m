Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12B44C4EE7
	for <lists+linux-edac@lfdr.de>; Fri, 25 Feb 2022 20:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbiBYTeo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 25 Feb 2022 14:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbiBYTen (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 25 Feb 2022 14:34:43 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898741B0C56;
        Fri, 25 Feb 2022 11:34:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXGJMjjIYRtstxvSHbpyGhFTz3ALUqG9uNK3ItfkJVIOYUzzbQunYzLsXWKMFiDSPa5s1WnmtNauxTuGkxusxLfQ1963hQ7laN3VZ6z/+ONZcFiMozvRHzoQupvvJCus6Ky9YRprMjLFrEUTneXthu0W5nt2WjLBLb1+fhvpObgl2Lq/h6Ehy9lVlBvGXXV+zRnYK5qWW1X+8zIUxNG8Nd2iLx/zYpyDzsnyTb/Xlr/CpaCKArWbLr1w98X107z+dIl88FtKps1Iet4zUYib0IofsG8/JkSTCL8GsbE8wMzmw0iOwrMInmTtVz2rQaI4uap8PED78C24n/orMgSb/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BE78gr+gZg9gWFTRdx3D2H6+H9CshtRblYtcuY3AIcA=;
 b=KXM9981SH6MCQYieJkv3BXMHn5pMLieL7H8rJRPFdQAQoxRMuVQ2ciW0VnML0gHC2pAPvBPlwkvMyfUGtaS0aun+Ca4GvU5xbVsNatIJSvLDbUgH+M+kVaX/iSAE43FRePMdhwhHzfg5M+oJmiKhJ/XUALXGcHtQm62y7bagEyMLpmN9M4FZGxnNGxyn+013S+ZkfKzQo/ZcpXS2wi6J93zXxvvqQWQon2NN7Bs2pCop7zVTWfvNZ5mJSYr8S6AeD9yAtodwAxae3vFyLMzxh0zjs93mOBM2B1FVFydlH6v/iETTCgsj+AcPbx0WDYi0kMf/4lZSTvzE+1vx7jJI1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BE78gr+gZg9gWFTRdx3D2H6+H9CshtRblYtcuY3AIcA=;
 b=IYLyPeE/wNkuoQ88TfzLdXm4xJzSBjmHyQ96mhJ327Z/d0c7zZdVWv9zQxgbx3/P3xygjXCpP5gqpEh1tr3kXWC6Vv0d/gZwUYEUOAJ1/efvPaF6IIqb68Ldmk6DuytrUOoG+VOZ6v8MrqgyUxtca2jZv1sPeX1LNRTWCXty3MI=
Received: from MWHPR13CA0025.namprd13.prod.outlook.com (2603:10b6:300:95::11)
 by BN7PR12MB2627.namprd12.prod.outlook.com (2603:10b6:408:25::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 19:34:04 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::ec) by MWHPR13CA0025.outlook.office365.com
 (2603:10b6:300:95::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9 via Frontend
 Transport; Fri, 25 Feb 2022 19:34:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 19:34:03 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Feb
 2022 13:33:58 -0600
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v4 2/3] x86/mce: Define function to extract ErrorAddr from MCA_ADDR
Date:   Fri, 25 Feb 2022 13:33:41 -0600
Message-ID: <20220225193342.215780-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220225193342.215780-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20220225193342.215780-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c38f2121-893c-4c86-461d-08d9f895c7cd
X-MS-TrafficTypeDiagnostic: BN7PR12MB2627:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB26270E1D4DC7936512DE432C903E9@BN7PR12MB2627.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InoF1STtfAsH9vqCgNFXb3dGhhIeOqF8uXF0I8glellVTla8SoPbW+Ea18RgH3TwR0Ijig9X10+tNkdsbaMJYIaVY9XYviTEAxkf9PEu/sY4LD2H1h53sdZyrxtpxgUaSOahH7nQGjK5UmMKIL6FWOMHmc24QvbEaJwGW7FpQGRzMFJxfn2ZWjWR7odcoSZIJoUxlICqF+AEwguygie52ESCMDCNvrXB9ylj3Lx8vC9GJDZsslq6SzaKrg+mmJtsQp21BDQ3y1SnD3rmtF2z34sjwdUV90A0OT+thFVElmpdQJ13YaLDqEIHvpbKfwC9cWWiTl3Uf3L1k9xQDZWj4fR2U7HU8BOgGcJHEFbzvko+VtstanOIleVIBfVDCrOVpaMsOATwmtdUsJzWEiOaF7v6KjHEJna8GVdNfKp1PY3PRQnAKgxmKkEqFpxktl3987DLgOcF2cbuGAilCZFtGX4WKht/lLxWfTnV1s9wMGk7Kvfy980eW66iNSJyNkgTCbYqJC7N1wNbmQ/5Mib0nOIsJJIJtXhjLxgmTdxAjoXTjl3MrOx4GbbMOXDnpVhTZNYvNB2n00ZhG3oLhA9DZ+Zi3WwDpbWJZNd8zAI/CWQLi8xANbqb6ITMMrezsdw6mIwOom08+/T6hDaBgeE5A6dmACX2T/QEHm2BR+UWBHRqJH9tsJklfFEtdaGYhw3PPx2hkvpY5nboPV3JFIcYYtKsMdObdukJxufqJA38e0C89wrbJ2joD1zFZtwOMFIDmjkpqo+O22sIRLjh/vvQ1CPFAEP05g0seY0ZtF7bu04=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(2906002)(83380400001)(36756003)(40460700003)(356005)(86362001)(36860700001)(47076005)(966005)(82310400004)(8936002)(4326008)(26005)(7696005)(70586007)(110136005)(16526019)(316002)(1076003)(186003)(2616005)(8676002)(5660300002)(336012)(6666004)(54906003)(70206006)(426003)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 19:34:03.3695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c38f2121-893c-4c86-461d-08d9f895c7cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2627
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move MCA_ADDR[ErrorAddr] extraction into a separate helper function. This
will be further refactored to support extended ErrorAddr bits in MCA_ADDR
in newer AMD processors such as AMD 'Milan'.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20220211223442.254489-2-Smita.KoralahalliChannabasappa@amd.com

v2:
	No change.
v3:
	Rebased on the latest tip tree. No functional changes.
v4:
	Commit description change to be void of the patch linearity.
---
 arch/x86/include/asm/mce.h     |  2 ++
 arch/x86/kernel/cpu/mce/amd.c  | 14 +++++++++-----
 arch/x86/kernel/cpu/mce/core.c |  7 ++-----
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index cc73061e7255..99a4c32cbdfa 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -337,12 +337,14 @@ extern int mce_threshold_remove_device(unsigned int cpu);
 
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
 enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank);
+void smca_extract_err_addr(struct mce *m);
 #else
 
 static inline int mce_threshold_create_device(unsigned int cpu)		{ return 0; };
 static inline int mce_threshold_remove_device(unsigned int cpu)		{ return 0; };
 static inline bool amd_mce_is_memory_error(struct mce *m)		{ return false; };
 static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
+static inline void smca_extract_err_addr(struct mce *m) { }
 #endif
 
 static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 1940d305db1c..981d718851a2 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -722,6 +722,13 @@ bool amd_mce_is_memory_error(struct mce *m)
 	return m->bank == 4 && xec == 0x8;
 }
 
+void smca_extract_err_addr(struct mce *m)
+{
+	u8 lsb = (m->addr >> 56) & 0x3f;
+
+	m->addr &= GENMASK_ULL(55, lsb);
+}
+
 static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 {
 	struct mce m;
@@ -740,11 +747,8 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 		 * Extract [55:<lsb>] where lsb is the least significant
 		 * *valid* bit of the address bits.
 		 */
-		if (mce_flags.smca) {
-			u8 lsb = (m.addr >> 56) & 0x3f;
-
-			m.addr &= GENMASK_ULL(55, lsb);
-		}
+		if (mce_flags.smca)
+			smca_extract_err_addr(&m);
 	}
 
 	if (mce_flags.smca) {
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index c0e9aa9c8749..313058dc129f 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -645,11 +645,8 @@ static noinstr void mce_read_aux(struct mce *m, int i)
 		 * Extract [55:<lsb>] where lsb is the least significant
 		 * *valid* bit of the address bits.
 		 */
-		if (mce_flags.smca) {
-			u8 lsb = (m->addr >> 56) & 0x3f;
-
-			m->addr &= GENMASK_ULL(55, lsb);
-		}
+		if (mce_flags.smca)
+			smca_extract_err_addr(m);
 	}
 
 	if (mce_flags.smca) {
-- 
2.17.1

