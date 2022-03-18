Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0814DD8F5
	for <lists+linux-edac@lfdr.de>; Fri, 18 Mar 2022 12:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbiCRLb4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Mar 2022 07:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbiCRLbz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 18 Mar 2022 07:31:55 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8091ED077;
        Fri, 18 Mar 2022 04:30:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqMQpBko0ugPNwFtRLqcg9nE4kvJAOFyNVRKVEFVvTASFN5wsrYY9mr6XvxwqhkUYibCrdL0LsrjglEDWKgcyEf617KbKixYAOmc9WgJFld6v11U2EzU4ZBwltfD+oZFiskVaPFDoTfmn9N7pO1AcI1W66Sr9SgGM856f3H2cYtFxYD2qV48DH8cShhIIeqM3AOr37Y/W/UeUHw1j/bgee1qCKl2uXhSJq49zKqI5SBnZBQrcPAtUtEwJGxLNzjGgzFV4RlZOyLcS/33kbR0sr1I59Mrx4VreUqI/C3IJfAKvZC5s9gSQpcBx2nIne3L2FY5QfRT2ykpPNSvdFwH+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgtrbmCfDU2xNNEDtyvZhTE4rQ1UpZxK8W9FW+UREVQ=;
 b=Bv4C0fzjl919Eb4P6H4TdbpQaRuy6UnAbJoTMpws42SR0QG42H74HlHTrSpMjdgtf55r6dgRZGPYkV9jBHF6njqMPYO9l2ThUZHyJayE5SQo/8wis12OUvZAe50ZgxSpWGKyBnO8Aj4RzG8/dRiTm91penikjfN3QGKq/dtcUwobnRQbhoPgkiVIclFhvBvV5jr5U0qtYf1QsHY1Z/qdeMo0SxZ02mgcbb4NK5Snnfb3c9OAQQLhwT3S/mkvTxekRyRhAZt2fLkErjE51jgLu14P32Ny2NFfcG5wlmz4rL2OkChMfQuDpvq0Shz+sL2gk39P6G4fpnt6Jb+dAG7BxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=nxp.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgtrbmCfDU2xNNEDtyvZhTE4rQ1UpZxK8W9FW+UREVQ=;
 b=ToiOW/woEp7Lp4Oofl0B4039LZC1MgMgocEUJgewgoFw1lkHIci8ooTXNZAKc/kICj+3V33SRz5JiliF9erhUw1eV3x+nM842WqAh1UUvu/dAwCsbHDWSCo3VA9Ydti8KSNFOEP2e5cFLgcD7ijc+1Mm37KF+3f0OyhKlg5f/dM=
Received: from SA0PR11CA0017.namprd11.prod.outlook.com (2603:10b6:806:d3::22)
 by SA2PR02MB7516.namprd02.prod.outlook.com (2603:10b6:806:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 11:30:35 +0000
Received: from SN1NAM02FT0030.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d3:cafe::66) by SA0PR11CA0017.outlook.office365.com
 (2603:10b6:806:d3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18 via Frontend
 Transport; Fri, 18 Mar 2022 11:30:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0030.mail.protection.outlook.com (10.97.5.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Fri, 18 Mar 2022 11:30:34 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 18 Mar 2022 04:30:34 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 18 Mar 2022 04:30:34 -0700
Envelope-to: sherry.sun@nxp.com,
 bp@alien8.de,
 mchehab@kernel.org,
 tony.luck@intel.com,
 james.morse@arm.com,
 rric@kernel.org,
 linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-imx@nxp.com
Received: from [10.254.241.50] (port=49512)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nVAo3-0001TA-7A; Fri, 18 Mar 2022 04:30:07 -0700
Message-ID: <ea5cc404-ab52-0df0-d3a7-f010e708a12d@xilinx.com>
Date:   Fri, 18 Mar 2022 12:30:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/2] fix some bugs in V3.X Synopsys EDAC DDR driver
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <michal.simek@xilinx.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>, <rric@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-imx@nxp.com>
References: <20220318111742.15730-1-sherry.sun@nxp.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220318111742.15730-1-sherry.sun@nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95bab289-eb9c-4544-10c4-08da08d2b809
X-MS-TrafficTypeDiagnostic: SA2PR02MB7516:EE_
X-Microsoft-Antispam-PRVS: <SA2PR02MB7516214D387FE9A3A2F22E98C6139@SA2PR02MB7516.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cH+m7Pc+3MYuM1Fk4zQ6XJOXdKCoY2dr4aqChRUFkI6rlH0Dsm/uea8SJYnBMKpWz7gvXiQyn8wAnqVt1NE1r8kLL0yJCdHIpxSs0THetE5ICRAGMUe7exo8emfraXZHgx4QXrjnDzI3o/XA2vaFG2rxcQNl5UW1ynWkg+dDFm0eqZq+McYaCM3Qlc8962kRC9VVot+Nd1c22qAD2J4dWUXoBngUuUsFgY9L/NOzHXqI0ZJsUfOaKrwLhF/4RQJAlqbP14r7ICagV9tWJ2WVUUVrZqBjEv1lxuO3JwFHCyueVzIO/lyfjJIcTwCUChIifvGzXxOC3MSi6CqDue4jur0d7XqaBCG7Bcs6UoXnAyAYFDZMi4tbFnl4voBysI7wg9+YenGj0M3vG2uk6H/w03BY2FoTgWlEiaqhiNvy5YMlqR1Txog8aMGo7sb4kQr/ssxW4aDOQyqCTskhDF3RqFzIJW/S0qlp6Du/HFwqwfQkaHhDxkm6x/QFzRLA2wfKspBmOVPpmrHqw3AqOvpF5gtx7y4WIJpjeqAgWy4g/OnoCSXCvNPpRmOoZQ9zK41bbqc16VxrlU59xITHMGLLrcBzZAC5AqAuj44Czk0KyuBTgk097lvakR8vVYRZZF8f1hBWem9yZXt2HpbcmCVG9AYGdyD3MxurPlh12sdeo2YMdW1sv+KJ5QVibas8ryyc8JHfcYtfpDM++E9j3tsHc9Ngi9Oed8VsmjI2ceqyF2DdJFJz8trvQnP+wWl5exUe
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(9786002)(31686004)(53546011)(6666004)(2616005)(36860700001)(31696002)(110136005)(316002)(8936002)(7416002)(508600001)(36756003)(7636003)(70206006)(70586007)(4326008)(8676002)(44832011)(83380400001)(356005)(82310400004)(186003)(26005)(4744005)(2906002)(40460700003)(5660300002)(47076005)(336012)(6636002)(54906003)(426003)(50156003)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 11:30:34.9321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bab289-eb9c-4544-10c4-08da08d2b809
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0030.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7516
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

+Shubhrajyoti.

On 3/18/22 12:17, Sherry Sun wrote:
> The two patches fix some issues for V3.X Synopsys EDAC DDR in synopsys_edac.c.
> For the details, please check the patch commit log. This has been verified on
> i.MX8MP platform.
> 
> Sherry Sun (2):
>    EDAC: synopsys: Add disable_intr support for V3.X Synopsys EDAC DDR
>    EDAC: synopsys: re-enable the interrupts in intr_handler for V3.X
>      Synopsys EDAC DDR
> 
>   drivers/edac/synopsys_edac.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
