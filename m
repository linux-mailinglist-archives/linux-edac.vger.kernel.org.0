Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA674A7373
	for <lists+linux-edac@lfdr.de>; Wed,  2 Feb 2022 15:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbiBBOn0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Feb 2022 09:43:26 -0500
Received: from mail-bn8nam12on2078.outbound.protection.outlook.com ([40.107.237.78]:58977
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229829AbiBBOnY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 2 Feb 2022 09:43:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQ3Pu/9gc0Kv2r0u8puXuaQMRgbKclJJ24yJkEODHV/gPLI1lvd9Ym+LkWhUAi5eB+pWqBJtuqrof8UDCue+0/yRZB2y0MjT8uEmJU4lNehGnxEhFI8k8ZBEcnvSw1aSWcDhUPpe17rO5PQIhxYSHFLisP3e136mVE7iJck1yLrFFX7OgqESZmjwQlOJepuu8ffcdZjGxwdaPVvMr4XhSU3IsmCOLzPLGg9LSDQtk/bOekS+bg/XR0Rxe566GKFqe4LS95j3VHtnyd29cZCO9yiaJWlztaNfIIVVS2UbzuQAjvkSkaGvg53amoVjRmhLNOttwY7iIpWZjhDBqVwn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGO9lAXrXSU3pHz2/2whSI9ZVzacl8XXv8YgREJ3Op8=;
 b=UEIKU7BU7h5QbiQXQkS4OgKJWp//bEX1hJnV4txmqfXRW0mxVkq6pimL98z2re3HaLEFsLNvdXzuzFdJ4t53sw/TH6fJmDvVVNN88lw0uf7EF+RO4fnAUxWxpSKC4HutkmlsNQVDq7b3WLenhswlgF7+YW82hwKmYWXFDzV802pLeme9hJTmAHaGf5rlvlQM5wFhKSs9eVRjMon0cbf0O9Rz/q/gXa9WdSUngJlpt6gIK0zN5NK0/jX3JVWKATDYwKUtuIpqjj8WsOiK1UryXAnZ6vXQ0slEvmL1HGq0DY8ZvgrgLJ7EAzdDt04r36Wj6qXTx3Scqps7GteK6brWuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGO9lAXrXSU3pHz2/2whSI9ZVzacl8XXv8YgREJ3Op8=;
 b=bVaW5jXOUK8a+acmpyoWrPYY8qpQRUlVWMOoT7ZopYpD4bgIxEYSPnh+heu27tNzCVpeGlqlGqKKuORTBeS+g4amcOO5Zvz35xVhn6HgHECUcmuuzVW1FI1w9ZseACUJg0IHeIE7h2+Xhpml9bRjJtZ0N+omw7n5eZiL6GsgE/w=
Received: from DM5PR19CA0053.namprd19.prod.outlook.com (2603:10b6:3:116::15)
 by PH0PR12MB5402.namprd12.prod.outlook.com (2603:10b6:510:ef::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 14:43:22 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::a3) by DM5PR19CA0053.outlook.office365.com
 (2603:10b6:3:116::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 2 Feb 2022 14:43:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Wed, 2 Feb 2022 14:43:22 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 2 Feb
 2022 08:43:21 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <william.roche@oracle.com>, "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH v4 0/2] AMD Family 19h Models 10h-1Fh Updates
Date:   Wed, 2 Feb 2022 14:43:05 +0000
Message-ID: <20220202144307.2678405-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de1397cb-9cd6-4149-7fa2-08d9e65a5ca8
X-MS-TrafficTypeDiagnostic: PH0PR12MB5402:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB54029F82F4CF4B4C91FD847DF8279@PH0PR12MB5402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2k/yRRwCvTdZlJ7UO9y0vOWKwSJox/3gzNgsEg7cLIx1o8PWNh/dYg4dVTTNTFy23H2DHs/p4s7ckGSSXRGLQM3ASrYzs8loPP+wwgv2I5JYHdNgvwplZ/1uOVKseWLoIAblT4cRZ1pHxgzYuHlu3+yqUTdhAsAL9gZGfg/K7N4E/nMFWw8S3UvTLmbqjHMn4EV6x+aLGnoBnYz9Zor9ZmBRjNFF7WIYMckJAcG5H7Ga+5nyVpCTxFYrkT0Wwy1B3EwDkz4ISvUiQcoe3jPdi5BCoJBHlX4FcEqBu83KDRKTii0HgM0NRXdcwCzU2i31neO/VjkUdr/ure6VxFpCfyxSmHsF8iHSp/Ou4iioJJoMX+U2mwu4VLYY579DmnO0hd51lqjH8b9niNNw8MUkx6MY369nNvUQAoz33XQyHRilJpBcnVTTYmeszJFmdtNfLWNC+3I57OLyJLoOhAEi0i6SXPzbD1EwQCnmJ0mzXPv/wJnbJq5h365r2TLf1t7PwYLKMbtecaNRsmvH3LqLNYb5p7ZUTwlai67shEPBYX6wpw14w0bxWhyFI7cisWr87Iitrink2mYewVYZiN7xPu3wr+wRLhNwdQcwT5Mt7F6npLgfFT0NteXicr3nFnvpwAwbwDFDKJYBkJE9ZnGqM2jKV4TDiwhNWxEWvYTp0cngQ50LA1rRYwZPOSRy8dU/wG+71Wqhjtl3VhRgs1I3MAgDiBaHEVGOCDsX7QSijw/glLdUBCcuGsPRqp4h0R7qXvVjm4W3Sz8PEAA2ODe3LBbDo99EsgvJmdguo7gURgc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(4326008)(44832011)(2906002)(83380400001)(70206006)(15650500001)(70586007)(47076005)(86362001)(8936002)(8676002)(5660300002)(316002)(36756003)(4744005)(54906003)(6916009)(356005)(7696005)(1076003)(26005)(16526019)(186003)(426003)(966005)(82310400004)(40460700003)(81166007)(6666004)(2616005)(336012)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 14:43:22.4533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de1397cb-9cd6-4149-7fa2-08d9e65a5ca8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5402
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi all,

This set adds support for AMD Family 19h Models 10h-1Fh and A0h-AFh.

Patch 1 sets the "memory type" per DIMM. 

Patch 2 adds register offset and other minor changes introduced with
these new models.

Thanks,
Yazen

Link:
https://lore.kernel.org/r/20211228200615.412999-1-yazen.ghannam@amd.com

v3->v4:
* Updated patch 1 to cache dram_type in struct umc.
* Fixed uninitiliazed variable warning in patch 2.
* Switched to a single register helper function.

v2->v3:
* Patch 1 completely reworked.
* Patch 2 updated based on comments from William.

Yazen Ghannam (2):
  EDAC/amd64: Set memory type per DIMM
  EDAC/amd64: Add new register offset support and related changes

 drivers/edac/amd64_edac.c | 113 +++++++++++++++++++++++++++++++-------
 drivers/edac/amd64_edac.h |  17 ++++++
 2 files changed, 109 insertions(+), 21 deletions(-)

-- 
2.25.1

