Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708B15F617D
	for <lists+linux-edac@lfdr.de>; Thu,  6 Oct 2022 09:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJFHOp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Oct 2022 03:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJFHOk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Oct 2022 03:14:40 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66E18D0FD;
        Thu,  6 Oct 2022 00:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5XmLjF9b56pf1lOlSbq/fgEM0Bw9p/oLhzSA7x8hfbBZuV+IE1nTjKi/RUe1cGpqaAbM4KHrF9ip4SssOjniQggZamjNJE9lAFrNqU05lGyRPfRjuWfsdbmrcmBImDHXYLVmto6hchU+fhjc3bpmkUEzPnvYfFaFlQ9YQdB1uTsJDqev2Dnr/GS30poPtloL59OkwdiPk33ARiYbNa8m+JWvBg+Xk+eAbe5M/7c7MYpfpIiv/JeQxhAwZsNKGoOBkh0pmMrrejdD99R39vMKK6pivhH67vAbIOomQeXpzaMeB3nWRuwYHxVwVj/lMWTWcQ9wzeN1rdbdglzcU1CiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwovLGL0mqlzYJFZJsZBAAoaVV6JMScJ5HIeEf3m10U=;
 b=BAHFTxIMtZbH/Q7Czxp0EhoVoP7qkjsSbiAnfjIXalMqEX9Dy9yKY3Pib8kBYpFC9eDqbZVBEz8Duv9aK+7U1OIPmoouy5MD57uNdswBljGs5oDCyk5rSWzgFgPkLdLWmEvEcBtZC+dfOjPEv/dOs89HLOiNZ509Sjnt6xiqpQR47f/8NqP9Bc/mljSZ5eOZn0Lo2lcVnlTSTTb8QfDwg9zHzKnOa43c75o8ZURn9L+OcNq3FKuqJlqw8T6F1k0saLeg5x8P3CF3/Kpup35LJS1qRU5CYRreadBzWK6TeR/ClvoUsYNICwS3/gvYQB09Au39T60D6SWFh+U2zqd0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwovLGL0mqlzYJFZJsZBAAoaVV6JMScJ5HIeEf3m10U=;
 b=AtR/qbQpDfau0k+WPdsYpQeR3v5GNr4s6K+30HmzNQh4J9S1WHPAa/VDS048tC2KLUhJBNTJ/OscJY7KkNcfiJDPwDXvaTw0SQX5EGvPHwmdseqYVP09paODCGJ3LVbmbg3BPKD01Ss/EWdq9IT6nE/vJMmVhHwM8GVoxEiBWzc=
Received: from MW4PR03CA0162.namprd03.prod.outlook.com (2603:10b6:303:8d::17)
 by PH7PR12MB6489.namprd12.prod.outlook.com (2603:10b6:510:1f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Thu, 6 Oct
 2022 07:14:25 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::46) by MW4PR03CA0162.outlook.office365.com
 (2603:10b6:303:8d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Thu, 6 Oct 2022 07:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 07:14:23 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 02:13:55 -0500
Message-ID: <ce69cdc9-b410-1c69-79a7-bcb8fc3bcc14@amd.com>
Date:   Thu, 6 Oct 2022 09:13:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH RESEND v3 00/17] EDAC/mc/synopsys: Various fixes and
 cleanups
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
 <Yzb9SyWh31rPCFJV@zn.tnic>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <Yzb9SyWh31rPCFJV@zn.tnic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|PH7PR12MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: b388e173-8b72-413a-4487-08daa76a65a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vcmyPcXL5Q6mcT64+pDNfdAI5d0NGdPiP1mfL8MI1TqJl5aZvJr/d7HWBNQuZfS3w8jMTeWw7Eq7PE32q8L+2cw5RIM6L2+T7cw5NtdaJ3ulIk60z4Rjm4rtHIN5poo6iJIhkDofY+ujIXufvRlo0boOtNrBfsMrqTuZ4QrBS2Vs1oFdrMeSyY3AWm3yhj01NwedX3KMVpADh1M0H4kg+wqigrFFw/cpo0KMR7A7Eufn66l+KXeeiAlulk9MgkPVA7Gl/5eBGeU86/0fuHJWzt6rolmAOvVKh05P7Gh1htWxY9dSWe1p8G5SsmzbiN948GyRvkFfYbDI6a/5Dx/q+Hl7soqDhWb6j2tW1ZgJw5dc6RN4ynieuwprPMD3OcXKJpsSysULeSbRl2mLaSwmRomorFZZNAtCSZSXjsO05nxwdoi7//FjKYfakFOoe/OWVJeKS+oOJtNYvTRAOJX7nFfaTj0/kzcmHqSQrOAovJY1u+p3mGEzoAvOW2WvnTAzpNtLh7xRa0sAOcFtnoY85C6HVmD96x/rjULUxOGQPZNED4keMetdm5EovH6x3Jej4IOvXn95AVZ18r1gCVrRL4VgX55VtI+q57bWMH1fiPVWto3Nz6sU/JVAjWt7qYu106z5+cI/YUEvQC06B13N5HiGlsLkt1NMGl/owzA5VZDtK3Hkt0h7bkYJZW7avCKv0kbwgkIpyBYPK6ijv0nnGPBngCbRPoVR/NZHhs2zkAJfHUyZF0YuAVmv/OxnJ7rV8FPpueivsdkQq5Szk/cksvdqh+BggiWAFPqNSyVbMAD/Lxnln4XWhEf5B9DctIzGSFKG2PKNoLNbhtgaFs7OI2hbOs/LqWWkzi90ujHOaAe2wk4Tu8oGt+6ScdrJpghRpD6G22lTDRLISGudg0Z2iw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(966005)(36860700001)(26005)(478600001)(40460700003)(36756003)(6666004)(83380400001)(8676002)(53546011)(82740400003)(316002)(16576012)(41300700001)(70586007)(4326008)(70206006)(44832011)(356005)(2906002)(81166007)(6636002)(82310400005)(5660300002)(8936002)(40480700001)(7416002)(31696002)(54906003)(110136005)(336012)(86362001)(31686004)(66899015)(2616005)(47076005)(426003)(186003)(16526019)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 07:14:23.7976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b388e173-8b72-413a-4487-08daa76a65a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6489
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

On 9/30/22 16:29, Borislav Petkov wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
> 
> 
> On Fri, Sep 30, 2022 at 02:26:55AM +0300, Serge Semin wrote:
>> This patchset is a first one in the series created in the framework of
>> my Baikal-T1 DDRC-related work:
>>
>> [1: In-progress] EDAC/mc/synopsys: Various fixes and cleanups
>> Link: ---you are looking at it---
>> [2: In-progress] EDAC/synopsys: Add generic DDRC info and address mapping
>> Link: https://lore.kernel.org/linux-edac/20220910195007.11027-1-Sergey.Semin@baikalelectronics.ru
>> [3: In-progress] EDAC/synopsys: Add generic resources and Baikal-T1 support
>> Link: https://lore.kernel.org/linux-edac/20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru
>>
>> Note the patchsets above must be merged in the same order as they are
>> placed in the list in order to prevent conflicts. Nothing prevents them
>> from being reviewed synchronously though. Any tests are very welcome.
>> Thanks in advance.
> 
> So I'd take a look slowly but I'd like for this driver's maintainer -
> Michal Simek - to have a look first.

It is assigned to my fragment for quite a long time. Origin author Punnaiah is 
no longer working on this driver. But we have new owner Shubhrajyoti who will 
take a look this patchset and test it on Xilinx HW.
Shubhrajyoti: please take a look at this series.

Thanks,
Michal

