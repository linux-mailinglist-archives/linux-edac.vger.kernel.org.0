Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08784EDEEE
	for <lists+linux-edac@lfdr.de>; Thu, 31 Mar 2022 18:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbiCaQlC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 31 Mar 2022 12:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbiCaQlB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 31 Mar 2022 12:41:01 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D7D1BBE2C;
        Thu, 31 Mar 2022 09:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzHsAxpFzx/ynU6AXJ/xVUKj7H7HkrUXt4pKUUbzBbkgb/+eHb/MU1IR817ndmAWaEYrIynWXdokgCkvsvrEGGIRNM1M9DNxud5RAXh+mDXY9lHv7zfggnvJesaK9WGOd/dfC48H8W+w36vXFM3IqTe7Dx1umY1uYadRhuzIX4GteQpK8AXMNs1Nsl98jsKtvjdiMLcoYLrdeZ6ZpPdjbgxcVUGLZArOIsBVq+AVRXVSQDlUmAup8sD+Yyn36Ye1NMETaGJi5oGIRoehELlCIeSHexk5HbZBeK0iPvxAMlwzxVnE5UhORVdcKnROoJWppt0vcNFWwOAv7+zwgVhY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQ74BU/jpu/Hpjo8rvIrNpdR+AAx04D4F8ZLykUkzBg=;
 b=HrCcPHlEOvYJkxr5slGok+HrdWHhdumbja7U2auRUcYcI6Mg97q2KzMXdAEAnpq60pdyEn5VgyLVL0xvMfTsM0dV6Obosp+00I5gGOsUa6VyDwiAacmEAUGahzcZS9zVo3zkXauVweutWMTjFTNOp3x0ag0x+2Nm+EE+2oVVB9wrAklIOsB0F/8gRasvI83atq8Q4uP6BUo8sOCFJTQ0QyQyL9TqvjXSABdrrUNtHp5zDf6XVuf4IO0trJRWE0peWVox6y3ablnuhmD+zJJLUbeP/x589y5a9AcFW01sR2c4iQelB7tlRrDn0Arc0/Lgo87cn5JZhqnqDLTnvN7axg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ74BU/jpu/Hpjo8rvIrNpdR+AAx04D4F8ZLykUkzBg=;
 b=R4eJQctWkafBTNfw8VJR+HYzieGyDqBmEsGWOkZHOksjNQWluFHjDQ8mEzvVbK2g7FlT95jHgxy5pSI9/s1PszwonxopC6k7mo4cdG5fE4SnlEm8gbicxtf3lTnGwXuSzu7M62y5NzDuVAdJ2tUjEnbGxjz3aSlkclzA5+Sra0k=
Received: from BN9PR03CA0368.namprd03.prod.outlook.com (2603:10b6:408:f7::13)
 by CH0PR12MB5169.namprd12.prod.outlook.com (2603:10b6:610:b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23; Thu, 31 Mar
 2022 16:39:12 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::7) by BN9PR03CA0368.outlook.office365.com
 (2603:10b6:408:f7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.22 via Frontend
 Transport; Thu, 31 Mar 2022 16:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Thu, 31 Mar 2022 16:39:11 +0000
Received: from ethanolx1ade-milan-genesis.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 31 Mar 2022 11:39:10 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <bp@alien8.de>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <bilbao@vt.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v2 0/2] x86/mce: Grade new machine errors for AMD MCEs and include messages for panic cases
Date:   Thu, 31 Mar 2022 11:38:48 -0500
Message-ID: <20220331163849.6850-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7eac7817-6507-4b62-cd0a-08da1334fc08
X-MS-TrafficTypeDiagnostic: CH0PR12MB5169:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5169DF3243FE9C6C614673EBF8E19@CH0PR12MB5169.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1/TM/uR9NlGk4A1pCZIbiaRqYFIyhbGf1gU3CkNRq2AH/QEdXFGYfKqZqx1fnrAstcXvAJvVGDe4hll/ieoKzpbe6m1hjhUdBT3VKe+bUp4YDhnxb5H5krmqIw4s91TUBB0H7swIqDJeNgEnDa8jHDVmgVe7RcFaI84+GGzGl34eXhbGzfjGy43vlGzzF2r1YcTgnZwDhlD2b9EuQj22Ad9c/CdFmilYg90nrmFR6fK8ZxshmqqUgnsEcJKB11XQRxIUBEJ4bTzCIiUX4U+7DNhRPVQO/FCHDxXukbpTsn57DxCXkKGl2vCTDL363hUCZ9B6zO0f+F7/xPh5uKZeciQqe2ZQiLEsKbN491QCUFzu7CQzn8lHdbAmAwOp5O8Je8EtRdGNj1EqkFdZRvImXWwg+onMpUqyx2EoROyk0ubMh5bbytahUVt+X293DBn25dxOq/422dITNACY2DUJc4z3yEnwoKsC8Ymdbi7xJ+hhANJdV9TAc6Qkn378KIGSlf4SFXUu/8AlZUOVwmSQaptxLqefbomlkMEfadognAiubASmBS1sX5+Q0lYUsgRfTAWIRoQUaTREIcVWwgOkfXgBepNYCcpBJi/qf7hy9ZlYT40imbpPuKvj6Wtx9eO1s1JsHcxAlpInb9AmyMqn6OLH2dd8rB8O+qigvQRhPWV/PahiJ5CJwvpDxLNxFO/UguBcp4d5Jbx3e1L8YnjaYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(7696005)(5660300002)(47076005)(26005)(6666004)(15650500001)(86362001)(8936002)(4744005)(82310400004)(36860700001)(70586007)(70206006)(44832011)(4326008)(40460700003)(8676002)(83380400001)(508600001)(2906002)(81166007)(316002)(54906003)(16526019)(6916009)(2616005)(36756003)(356005)(426003)(186003)(336012)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 16:39:11.3227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eac7817-6507-4b62-cd0a-08da1334fc08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5169
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patchset includes grading of new types of machine errors on AMD's MCE
grading logic mce_severity_amd(), which helps the MCE handler determine
what actions to take. If the error is graded as a PANIC, the EDAC driver
will not decode; so we also include new error messages to describe the MCE
and help debugging critical errors.

Changes since v1:
  On patch 1/2, follow a simplified approach for severity.c, that resembles
  the available PPR more closely. This also simplifies patch 2/2, as less 
  panic error messages are added.

Carlos Bilbao (2):
  x86/mce: Extend AMD severity grading function with new types of errors
  x86/mce: Add messages to describe panic machine errors on AMD's MCEs grading

 arch/x86/kernel/cpu/mce/severity.c | 111 ++++++++++++-----------------
 1 file changed, 44 insertions(+), 67 deletions(-)

-- 
2.27.0

