Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D175642AAF
	for <lists+linux-edac@lfdr.de>; Mon,  5 Dec 2022 15:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiLEOtv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Dec 2022 09:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiLEOtt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Dec 2022 09:49:49 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5161C400;
        Mon,  5 Dec 2022 06:49:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHk4tlTnZa+ap3lJyvt2S5K+3d8zl00nvRUCOuVtDnm4W8DuG4KT+1Wot9iqF2Tf4E5m/2Lk1hY7edSA+UOhRJpqx4ubpGWags8FriGSFDOTW735ZNN7Iq5fWV1Byuo8kKW99daB7ON5v5ENJdQxAp8OsIwEerblpcPdl2jiJDGqPek4CaZK/pMk72PWorOyor/adkT5uo5R/mg2nCALLmrrrzhjDc1Y9ZaG0TN8cxKXFeuPXk7ab+xArZRtuIA5Dop3i95ycVJEXYV/mVc1rFG373pW5X1RU+qgYj297Ht3yluKD6pnEijYZyk4e877FRp1HhUUcicj0gS7lmRXeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4xWp2iiUEsC0w9BSWB9WI77/v1oo4L4mmu+hsc2UQg=;
 b=aLLErwxQgT0Jd3ULzLSL3bvDIvgRERXNnkGcUTrTT9SxKaB69D0TxpcqAbM2iJUY4oTP9ac/4uILtkZqVvBChav4kHcHajmUw2fNAJnTwmH3UOAVskuHiuYm/1HOHPuN7xRd8AlNLv6Pps9YWpWLU88yNOEJ5ro/4rcUhXeYX/g1pn8erhqNolMJ7TG5CNVOARMWwtFm+lPT+eZeojyWLRYa9qzwHfKj3Yf+E1lg+jZWctlJyDnOfNdN0h2ONh7ZMpFioBJ6qzAGMUR4odjudjMY4+Y/8rXnBR6wVCduwx4o38YBhTDjMQguMMP17SD2TRS/5WP0HQCYZS+rLqdz6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4xWp2iiUEsC0w9BSWB9WI77/v1oo4L4mmu+hsc2UQg=;
 b=LGuF1LRd3Gy5FZdcCzJ9xikoOZBQ+E2paAW3pfoEgEvqdn2Bw51BOUjfFVuALDMSMx/HPYNKdlPj2ag7bRhA1z7+45U6Pr+QCKKOW7UBVG6vKNGVdsEVyUPdbSBY0JwbjcBRnxG/xlQ8Awszn1oEDax4uFYxObQlPyepviHnSLg=
Received: from BL1PR13CA0203.namprd13.prod.outlook.com (2603:10b6:208:2be::28)
 by DS0PR12MB7876.namprd12.prod.outlook.com (2603:10b6:8:148::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 14:49:43 +0000
Received: from BL02EPF00010206.namprd05.prod.outlook.com
 (2603:10b6:208:2be:cafe::4d) by BL1PR13CA0203.outlook.office365.com
 (2603:10b6:208:2be::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5901.8 via Frontend
 Transport; Mon, 5 Dec 2022 14:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010206.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Mon, 5 Dec 2022 14:49:43 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Dec
 2022 08:49:37 -0600
Message-ID: <330f1b49-eb59-c55e-3f7d-dfbf4886f247@amd.com>
Date:   Mon, 5 Dec 2022 15:49:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 2/2] EDAC/zynqmp: Add EDAC support for Xilinx ZynqMP
 OCM
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
        kernel test robot <lkp@intel.com>
References: <20221102070655.247511-1-sai.krishna.potthuri@amd.com>
 <20221102070655.247511-3-sai.krishna.potthuri@amd.com>
 <Y4DbXaan258cZK+q@zn.tnic>
 <BY5PR12MB42582EA4A4ACEA56367544E6DB189@BY5PR12MB4258.namprd12.prod.outlook.com>
 <Y43vJECWJI99tc1x@zn.tnic>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <Y43vJECWJI99tc1x@zn.tnic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010206:EE_|DS0PR12MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 480bb621-eb8d-4cfa-7562-08dad6cff1eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CYcQ/KrDPFjwQz70fjpvpWAkoU4CIH+kEy7c7j9wnv+dx8MnN7NGUe4jVcFpV3jy+jCahw2OcHVn+Y5ShqFDoEssL0njx5JbMzRgVcfS4lh1IMLun+wVof/JqDWfHK0km/U5JNQLHlQuUlPP07371JPJJXf+AxM9uxU/SfsckEwxbvecNc4RznigEfQfmciMoNhYVT6vud0jw/vUlg9BhV3M4q2dDRyN8E4R4+m+ZoWp0UQT7O0WCvQSXHL5C3Q6mpgJ3mKRFhXr1laHz8gxw/XIF/PihiFmutPyXqrYni18VAS7cDIG/YLPrOTSzxa8/Tc3/z2Yt8Eb2J/PqYksI4N1dgTOfY5VfjuqqchejaJ6euC6gb+rbHS8qX/gyEDedcTGAO9wqlSOn/Ql5xvaS6p9tInw/eaIUTOUWpfttiCQazbrLAZYHs38HBmU7uI7XPTW57dJnN+lxO9xuGnLPaBOO+B+be3pBnEt5FG8c05RLepDUYBLp5X7C1t3+/lIicD0ub1KcMBp33+O5zr1QePYmd6/5LPUIzdSOgUNb6ULA7TnZLCFNh+oopw4SfZXBdWL1WDg1dcXKp/yGCOJi4fjkUCtad9xGnXUQrw/vim9uO3mT7tGzDkR4+vr84miY4GCDvQjnd0drbNMAJkToAgPcc5PRPdYZDcf85Pos46dXKyok1avPNK0nM8t26VYGwonmvyopPj5P7ejXiwR1mSa7IcbWJ5HNyXUAgppbr4g4MgFi+A45PG5ymkKnLilMAVOMTLV1eqy8L2m3JYfjrnIkbz9creIQcdLdoyruI8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(83380400001)(36860700001)(81166007)(356005)(86362001)(82740400003)(31696002)(44832011)(7416002)(8936002)(2906002)(4326008)(70586007)(70206006)(41300700001)(8676002)(5660300002)(40480700001)(82310400005)(26005)(53546011)(186003)(6666004)(336012)(426003)(16526019)(47076005)(16576012)(316002)(2616005)(6636002)(54906003)(110136005)(40460700003)(478600001)(966005)(31686004)(36756003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 14:49:43.1192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 480bb621-eb8d-4cfa-7562-08dad6cff1eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7876
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 12/5/22 14:16, Borislav Petkov wrote:
> On Mon, Dec 05, 2022 at 10:20:11AM +0000, Potthuri, Sai Krishna wrote:
>> As we communicated earlier for ZynqMP platform we have both Synopsys
>> (for DDRMC) and zynqmp_ocm_edac (for OCM) drivers. Just to be clear
>> about what this driver is targeted for, we used ocm as part of file
>> name. Ok, zynqmp_edac.c looks fine, will update.
> 
> Yeah, we can always rename later, when another driver is needed. For
> now, let's keep things simple.
> 
>> Ok, will update API documentation like below.
>> echo <fault_injection count> > /sys/kernel/debug/edac/ff960000.memory-controller/inject_fault_count
> 							^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Any particular reason this should not be called simply "mc0" or so?
> 
> At least this is how we call them on x86...

Some history around this. Based on
https://github.com/devicetree-org/devicetree-specification/releases/download/v0.3/devicetree-specification-v0.3.pdf
Chapter 2.2.2 Generic Names Recommendation
memory-controller name is recommended.

Thanks,
Michal


