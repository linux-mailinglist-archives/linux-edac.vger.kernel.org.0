Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1463E81B0
	for <lists+linux-edac@lfdr.de>; Tue, 10 Aug 2021 20:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237658AbhHJSBa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Aug 2021 14:01:30 -0400
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:55361
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238290AbhHJR73 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Aug 2021 13:59:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abo4A4OHC+K2NFZE/DNEXdZyO8faGTcHidxeItJ9+43x5THDOWwa433qUn23Zk9ZPFA6Z8fSbIIY+vzKWk1/6hG3s2cWkDx5zBMn6b0aieB2nT1BauMDLrdP/obcx51m8A0roYFUKLDR1AULndKIyOLaMP1lHErVQFt0rJSqZKB7PATV+/NCCxmv29+adOKm6wNaJnt6OmcX7aQWbhIYzGA6AyQ8QnK3FGoDnQUcTLBbmEwhuzgLcy2t/QJQDfVxy25VndY2Od0Kg+n4wSNx+tWQlX8rQaDW4VVu+aaIY8t4Go4w0trCKIQhw/H3R6KIFzpVuscAlHU1Qfax7dpAsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpPPZ8UwmMWJX7gxQqjAVEJS38iG2G3gOI5Kaz/mXW0=;
 b=BuG9p+NK+V3tdREzrxSDW5Twdxj7ukcK+uW3kkA61xIHfbyRqotHVzFRyJI5lu0Ks/miK+1eCMi58TX+QwuSnO/QEiNKInJ/tP5+MBILiSPVBjP0DYUhd/v48/ppVmpkgcczw5N2/E5yHfPCGBeAC8t9Z276LL+Fka4qaMQvDSuwbB38Q4DUkVXhEJAet9lpk5Ik/id+yfaay5WZzSaR0MuGAm7FvqfOlUkNKl9scCw205IkQsC4Vc6U9v+lG7KEXHjufFMfMfBq+0EOWb1vxa25ZHGe/PZ+8FZZSUh59zEhHeNGM+FCXigD41PAvRkyU3q7SyOkGc5SnpTVuGGkvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpPPZ8UwmMWJX7gxQqjAVEJS38iG2G3gOI5Kaz/mXW0=;
 b=DIzskLNpWYyHvMRgtBFgrVndPtZJ8ZC/Ekn0mlSnk6BBb3aWjMhgM1YeTY4v1p4Zf1hv4Fq34cuBn0HbT16l17TpreNOJbzJIOpjj9Evaf+aGnkyLn5oLVaD+APDiq8L/0P6qhv6v/U3ZcUZjIiLg2BRMypG9tXs/35WaQmACwI=
Received: from MWHPR14CA0010.namprd14.prod.outlook.com (2603:10b6:300:ae::20)
 by CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Tue, 10 Aug
 2021 17:59:05 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::2a) by MWHPR14CA0010.outlook.office365.com
 (2603:10b6:300:ae::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Tue, 10 Aug 2021 17:59:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Tue, 10 Aug 2021 17:59:05 +0000
Received: from SLES15.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 10 Aug
 2021 12:59:02 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <mchehab@kernel.org>, <mingo@redhat.com>,
        <mchehab+huawei@kernel.org>, <yazen.ghannam@amd.com>,
        <nchatrad@amd.com>, Muralidhara M K <muralimk@amd.com>
Subject: [PATCH] rasdaemon: ras-mc-ctl: Fix script to parse dimm sizes
Date:   Wed, 11 Aug 2021 00:08:55 +0530
Message-ID: <20210810183855.129076-1-nchatrad@amd.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f491bec5-c392-43e7-90ae-08d95c288b3f
X-MS-TrafficTypeDiagnostic: CH2PR12MB4247:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4247262ED4299B44D3748725E8F79@CH2PR12MB4247.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QaXI/+p1nt8QlzbFHta5TeFZtv3RPmPPuSU3uHTjBgLUW8i5NfGui1ZBUVsKTvq5qjkci98KO3LD6Zce8dPZ8ImbzFCEAobOP8nocbhKt1NOhyT3m+M2KUxaIn4uCcD867IGE1ykLcKFBF6xQ3mF7U9G9bvgAL4gmWxCPnvCZ0Wq6padMEUVY62OEh+mzqRryjHILm+9I2PJrPs9aN35XU7WS0lXuf78etJQKCBHoHs1fZaCbpnC5sonrLtnP3JO6bdGtvdm2dXwsWYe45qv2bA87K0dcWAqiKt9Mw5ruz2aCLpfhES0NE56MpYgLlHXFG93PgIVgtvX9tBo8/e+Kh9YkbjmuQZsJK11akjc5qgqWxMUAxLRT8YOkFWuohrR/WlP8WXXP5fPl/XNN+7+UYu4ehSvvG1e5kv41cyZaqg24WNkz7PL/1r+Qth7lXgHrEwKe81l2Z8rqr6CsQ/s7UvPQGLf369lBn/F+3ziuM/9MOMB+i1Wazad5S4QGWVTM+LzmbVCk+SwX3YlKwn8m8FqISWUsEOnV4Ljj+YTqINeugTI1HNBgOIdOf896VOXTKQcM5poVMuNgLO5cB8Y/wacGHpvdxcBWbjscDYp6Mdd0zrBGu/NXNd/XrIYOPh1g4HL2bmNCaZniURWbSktvxoNQ8AgdxrQ8sTd5XR38QrWpQcKByo++xiSPYwUTCq1E8EY2FPob5t/Gv4HpSSKc492iZMMg6eyKchPSJz3dbZwDkxEWzxxLjRPHI1Pz08pYsHOFiieisTotLOSYT1LMO9rAwHCNOiBqrAZniixcnMxhvO6unp8mIJXk4qGveeB9YgODDNA7dr1T139bqpyKINGLjuXtpeZW31P7G5TJNo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(36840700001)(46966006)(54906003)(4326008)(5660300002)(356005)(316002)(16526019)(8936002)(336012)(83380400001)(26005)(81166007)(478600001)(6666004)(966005)(186003)(82740400003)(2616005)(8676002)(36860700001)(2906002)(426003)(1076003)(82310400003)(47076005)(34020700004)(70586007)(7696005)(36756003)(6916009)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 17:59:05.2742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f491bec5-c392-43e7-90ae-08d95c288b3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

This patch removes trailing spaces at the end of a line from
file location and fixes --layout option to parse dimm nodes
to get the size from ras-mc-ctl.

Issue is reported https://github.com/mchehab/rasdaemon/issues/43
Where '> ras-mc-ctl --layout' reports all 0s

With this change the layout prints the correct dimm sizes
> sudo ras-mc-ctl --layout
          +-----------------------------------------------+
          |                      mc0                      |
          |  csrow0   |  csrow1   |  csrow2   |  csrow3   |
----------+-----------------------------------------------+
...
channel7: |  16384 MB  |     0 MB  |     0 MB  |     0 MB |
channel6: |  16384 MB  |     0 MB  |     0 MB  |     0 MB |
...
----------+-----------------------------------------------+

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
 util/ras-mc-ctl.in | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index 1e3aeb7..b22dd60 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -246,6 +246,7 @@ sub parse_dimm_nodes
     if (($file =~ /max_location$/)) {
         open IN, $file;
         my $location = <IN>;
+        $location =~ s/\s+$//;
         close IN;
         my @temp = split(/ /, $location);
 
@@ -288,6 +289,7 @@ sub parse_dimm_nodes
 
         open IN, $file;
         my $location = <IN>;
+        $location =~ s/\s+$//;
         close IN;
 
         my @pos;
-- 
2.26.2

