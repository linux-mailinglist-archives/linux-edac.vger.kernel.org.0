Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C456F4DD853
	for <lists+linux-edac@lfdr.de>; Fri, 18 Mar 2022 11:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiCRKnK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Mar 2022 06:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbiCRKnA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 18 Mar 2022 06:43:00 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A8D2D7AAE
        for <linux-edac@vger.kernel.org>; Fri, 18 Mar 2022 03:41:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sfe5qxKNhCagBdtbfHabM4VXG1h31yyaGuYzjAedp5zfHB0RKRFr6zMZhEibHhN4zg9RLh74qU+nx37YcOnJ441+RHsrGM7/NMvxUZ3NaTvNl1BDU4cwdayEUm7r0D6LKlz3NY0F/GBqPxlOx8ph/gPG/A/7iNy5A91j+5FuZ4+KCrAabpYzv/hAqEe+EOPWjoqC6Dok+bhzDd3gwqrctPcvHghvFTdeZtxjJ32vItIGERvnUaonMi1tpFczQXj++8kiC633isflG7kIdewf4zZJwbYmN4afWfk7NPwmXsyVmANL0kmsrzuLRcGh0776+vQ8db1JwNC34oNVrYIWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jn5f8Q/G0YRXNqCvPyCMVmXuUw9Nzv+6hSP1byYxrI=;
 b=bGDYpGYQokfqshp2US/7XWc6kPTVevqdK76+6w78X7QrDRht4lN4JLcbt5jYjxOrbkeULAAjJZ3Yj4xhOp4XEqr0fGK7QBxQAFBV2vWUpBnaXRen0WCMoEE0Xq6OguKnh3leNnW1L7VSSV27wzVbH7T8B2jChCI/F1ZLDUp0kpgDmQYCZJ8dP+ag1GgA8PsbujxnoHzbDDZxdXcj9jzxJ4pQQsoXItxIAlnPjONi0xmEKmBqbPIo7PacmFAu4ga2m+CAIOHU4leXoHbs3IU+1Z+8LJW2reto3225ipR2N3ucTkx6OGakefaZkCqcZUVeCCan3VDtoyr4/OGQi2G1fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jn5f8Q/G0YRXNqCvPyCMVmXuUw9Nzv+6hSP1byYxrI=;
 b=qE3Za+PT2TkDHtDYu3oYWp8ybQPuBJ8JQolsd/+MsSiYyzzFdl9oCl7h0GlWWizJkGosmVtai0tGiVLfAcafNUSHRe8v2xILGfpR4eFmT1T5Nhfx8SG6nCdgo1r6AlMSxkQsrzJCaoR5zU466uEZI11JHBHqzKtaFmTve6KmrfQ=
Received: from SN4PR0701CA0046.namprd07.prod.outlook.com
 (2603:10b6:803:2d::33) by DM6PR02MB5451.namprd02.prod.outlook.com
 (2603:10b6:5:32::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 10:41:12 +0000
Received: from SN1NAM02FT0034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2d:cafe::5) by SN4PR0701CA0046.outlook.office365.com
 (2603:10b6:803:2d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18 via Frontend
 Transport; Fri, 18 Mar 2022 10:41:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0034.mail.protection.outlook.com (10.97.5.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Fri, 18 Mar 2022 10:41:12 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 18 Mar 2022 03:41:10 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 18 Mar 2022 03:41:10 -0700
Envelope-to: git@xilinx.com,
 linux-edac@vger.kernel.org,
 rric@kernel.org,
 bp@alien8.de,
 mchehab@kernel.org,
 tony.luck@intel.com
Received: from [10.254.241.50] (port=45326)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nVA2g-000FyU-5P; Fri, 18 Mar 2022 03:41:10 -0700
Message-ID: <cc43cae4-240f-1d62-c9bc-56335554a321@xilinx.com>
Date:   Fri, 18 Mar 2022 11:41:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] edac: synopsys: Fix the issue in reporting of the
 error count
Content-Language: en-US
To:     Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        <linux-edac@vger.kernel.org>
CC:     <rric@kernel.org>, <bp@alien8.de>, <mchehab@kernel.org>,
        <tony.luck@intel.com>, <git@xilinx.com>
References: <20220318101900.28872-1-shubhrajyoti.datta@xilinx.com>
 <b6821312-3aa8-6b76-81a5-45927d6cc1d0@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <b6821312-3aa8-6b76-81a5-45927d6cc1d0@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27f02b07-e353-451c-f395-08da08cbd217
X-MS-TrafficTypeDiagnostic: DM6PR02MB5451:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB54513D2DB8718EC63F34C1D7C6139@DM6PR02MB5451.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3qcvYvkf9KQ4tWXLRawHd90j5r/Hn9cob/nBQzBM2ojuzPx3awwbmxgR72UMP5FY+b7qykUQun82tkQ7MB5iqBjYuGB51ZW53WYfJBCKOJGW6PwTayl5usF8Zph/ES65sIz4WUbGQnl6A/KV8ASQOJi8uZ5vAcu+EGEPfd0SZRXwlw9NIjhqK+uX5nMDphw2tT7YsJ4WXbfPEY75/g6Fo5N32r+VHd7IG7zWWhb7oOJB4nnvJG+LWHD4mq/RNaYvbZ/fMmo4UsQAPAvDSTeoyhKXeLBEhTCIjihV6jMH9f9hh6wBXjbfNH3+bJVf3tfJ4C7kfC3xFM/W1+iLg29/VItGbD+huYIXChgvslcM8k/JCN9RPVefdIzvsTsPv3/3Gj6RX4YanfjsySYsb7WRdHx++8n6s1GRaG++Sh55IDzdlZw5S1uRLWQSfSfS0GcWz61qbxFz1FERiQHVhRD7jxoaypAYSxdmjDhdbLLXO3utdkPV67Xe34bNWdInuBF2RAvBHKXWA6kKRBy3hqrFMf1VTH92cQ3Y/vM5EeJJVM6GYCQ0sWf1NZlIrqin4q04J9OHukyS5swgWMuav4n/gG5+dM0U/jNVPeTxyFna1HvTqXSunuQk9edOtKO09RcF7aLo/dIwSTewxNyWsKvqP13/E979or7dBi0BFz+InXcIsP18U7M1m0kIkBwP4iaaZ453SNmfwgVMTHEfzaW7qUnhZHdzRVsF7ZwNbIUgCVY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(53546011)(508600001)(36860700001)(336012)(316002)(426003)(31686004)(2906002)(47076005)(6666004)(36756003)(5660300002)(4744005)(2616005)(9786002)(8936002)(7636003)(107886003)(356005)(31696002)(26005)(186003)(70586007)(40460700003)(44832011)(82310400004)(54906003)(70206006)(110136005)(4326008)(8676002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 10:41:12.1733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f02b07-e353-451c-f395-08da08cbd217
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5451
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 3/18/22 11:33, Michal Simek wrote:
> 
> 
> On 3/18/22 11:19, Shubhrajyoti Datta wrote:
>> Currently the error count from status register is being read which
>> is not correct. Fix the issue by reading the count from the
>> error count register(ERRCNT).
>>
>> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>> ---
>> v2:
>> Remove the cumulative count change
> 
> 
> CR number?

Please ignore my comment. I thought it is internal patch.

Thanks,
Michal
