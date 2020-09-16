Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1662B26CA38
	for <lists+linux-edac@lfdr.de>; Wed, 16 Sep 2020 21:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgIPTwU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Sep 2020 15:52:20 -0400
Received: from mail-bn8nam12on2089.outbound.protection.outlook.com ([40.107.237.89]:27841
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727904AbgIPTwR (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 16 Sep 2020 15:52:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjgXLLcuNG9tzeDZESfqxzaK2YSSaUS/d5ABCn5pbx2ZfnnzUnYLV5ez/LhmlmvVQ+T55dLe/p61LrayvJWBrL8RvFCvn5Wjje+kW3z6zgYncLTBZCQU52uVjzww1oQMIx6klqcKXJkzXqJtaAqW/x2r0kvM2GFRL1KqsE0jxghXXBYOV+x+zcUiZOPRKYlNXVrX6QPWxiTp0+NSXX7hNmdVPcdvknpAt6JO8aSUnTja7KyMDQrrxMSAh5H5ohANs9BvPzv1at9Lzfbkqap6Pi+gKwkSSOVE/vySuUH/9orAX8z4P0XlXOGEgXM4Hx30pQhnIHyIIyn4C/HUw/VaxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZ5bohymRVyrFC0kixiHJP+pGz+l+XM0BWqSiog4A90=;
 b=mCthpom6SX7nTBSVbEl0QtFXTbvLGQK9m1uX047GV7I1/7n19v7yQaY+aP1PtEagAJRUhhAju3mUwM7OCV2Q6WhEyyZeB1wCq5G98NHLX1Z1SCK3n8+yOoCYi1RQT65gX0s8zCmT0KX4y9b9e22o8Nk+aMbDxDgbeMIfAiXE334O/JpHzVBc0brlfu+VNpX7Ln8C9Bgy2UGFTwyH2oTpc4jbruxq+TkqrsmZ9RXfHPrAB2JFfT5LxnQDu92r3zGB0x3KQQGOrupLw74rbnGts9qYvsjdfEkqBdlg9GgBAN1eBZTklkjuj5dNdF1HpOEO5/IXvOpD569FyW9nfgSyZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZ5bohymRVyrFC0kixiHJP+pGz+l+XM0BWqSiog4A90=;
 b=LVYRmGuIfs0Gvuk64vUrsTUOeqNnxIcTMHOxgYPmHThFddwmuFjwsK2zKyWRu6dN8LSWUxhyLOh5YyMookkFrJH/8Rg87hho1P88vN9Gg5nUQxGm3ETxA0xaNBsW9H1D7cG11oszXTy2O0qcVVQTHlZv/oc8bxElRTt+QyLzZAs=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1571.namprd12.prod.outlook.com (2603:10b6:405:4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 19:52:03 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e%4]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 19:52:03 +0000
Date:   Wed, 16 Sep 2020 14:51:52 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 1/8] x86/CPU/AMD: Save NodeId on AMD-based systems
Message-ID: <20200916195152.GA3042858@yaz-nikka.amd.com>
References: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
 <20200903200144.310991-2-Yazen.Ghannam@amd.com>
 <20200909180647.GF12237@zn.tnic>
 <20200909201755.GB3014671@yaz-nikka.amd.com>
 <20200910101443.GC8357@zn.tnic>
 <20200914192039.GA39519@yaz-nikka.amd.com>
 <20200915083259.GC14436@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915083259.GC14436@zn.tnic>
X-ClientProxiedBy: DM6PR08CA0041.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::15) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.78.2) by DM6PR08CA0041.namprd08.prod.outlook.com (2603:10b6:5:1e0::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend Transport; Wed, 16 Sep 2020 19:52:02 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8dff4f86-ced7-48b0-f2d3-08d85a79fbab
X-MS-TrafficTypeDiagnostic: BN6PR12MB1571:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB15711A9914DC7A44F48242C1F8210@BN6PR12MB1571.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHM5K2XQVB6pHvz27mbTlDkGXsFL8uAm16/BFkv/6txgSGzLU+3k+hzAJkYNGKAEGbHcmsOcrMYNPXNeMLLN6aqt3gt8uP5VeiRsvipwY9RbaSSksDJMtJO/DQg5N/ng47jj8395EktjSmcfmF9Ff36XscMzw3GtB0agxD8V4cQ5ph1mLvbsXyTcGPOrKvedK9lnDnTw9WAP6vyZTRnmjYTYouIDZXx+PxLnAewlUDQvEeA3OX3yq6VXZJRtcWmOHRwRhx8dsMPL0AL3Z+Y78UFrK8f2Dj+6vU+3rwJ2BXgoQ4sON32vE+H68lmqJda5GFH0TnH9XsemaC71KAsbWvD8zfF1ZEGQ2TgMfmgOBqpfSqVTQ/LjVdpIg2x1islK0YpDtAIMi9nclDYUG5MSYvftGs2IPcsZBt+5XY2Pe+A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(396003)(346002)(136003)(376002)(478600001)(66476007)(66946007)(44832011)(55016002)(6666004)(16526019)(26005)(5660300002)(4326008)(186003)(956004)(66556008)(86362001)(1076003)(8936002)(83380400001)(7696005)(33656002)(316002)(8676002)(2906002)(52116002)(6916009)(98474003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: d/lE7fZWaKWwjaFdhNDDPnqPZX8PH1ra4t11529Cjkv8wfEixDDaqauXvjBcEwDdbFUl784FzQ1Yhz6Cwd97gJXXn+wL2yMlJFxnxHxhHkYV/CkcQuA/uncushkcCy17HWyuLSOIHShFBs13PdfDIv+au9YN4SD/iWhne8We60GTsm1jkL5bbaUibdNEoCr4LEQ+iOJRtlKznaodyBnGThXsmwLDKFUYTyvMF8BHxmGS+oZysjh9QbWnzNYBINcjIS8KYUKLe8eK8gHHHMjJGJ/BrApS9YYyTr/mvMHsxhd0MxFdFkkFvgD2+IfnRd/BkZFRUGQPKv++VzI+/cld0e/Ko9ZmyRfTVkP5BLknYGjyJ6R0LWIbnD/2DohnVMJtEnk3rOKGQ7CaKyBY+SzVIUEmBKrKS4tKEcRFNoeqAzNV1csaz1Kx6QzsDliLyMnUk/WoHj20S/qJRRlwHyWEJS+aV6DhDULbZaZJbZAp1RglIEXtZ4QBwvQv4VMjm7lsoeiwC7yxikbZACrJ3LleTgDEgy3HZ/harMELPyh3HL2Xl8rp4lrKdRxdzARzCdCBduuCENkhyb7KhlEFvuDqhHziBgk7EBhIJk1j/JlCP3lMPQRGrvznGucuiA7MZLzFfnO2PIHxYk6gW2qcTuwj5w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dff4f86-ced7-48b0-f2d3-08d85a79fbab
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 19:52:03.5716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5IR2RSjLgWPzd8/7VTcAyXpJB3o7wOS6OpO4YyW28x6E1AYm46PtBxXwOQ85rspSMs6gJC7oNd4PrWNANAV5Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1571
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Sep 15, 2020 at 10:35:15AM +0200, Borislav Petkov wrote:
...
> > Yeah, I think example 4b works here. The mismatch though is with
> > phys_proc_id and package on AMD systems. You can see above that
> > phys_proc_id gives a socket number, and the AMD NodeId gives a package
> > number.
> 
> Ok, now looka here:
> 
> "  - cpuinfo_x86.logical_proc_id:
> 
>     The logical ID of the package. As we do not trust BIOSes to enumerate the
>     packages in a consistent way, we introduced the concept of logical package
>     ID so we can sanely calculate the number of maximum possible packages in
>     the system and have the packages enumerated linearly."
> 
> Doesn't that sound like exactly what you need?
> 
> Because that DF ID *is* practically the package ID as there's 1:1
> mapping between DF and a package, as you say above.
> 
> Right?
> 
> Now, it says
> 
> [    7.670791] smpboot: Max logical packages: 2
> 
> on my Rome box but what you want sounds very much like the logical
> package ID and if we define that on AMD to be that and document it this
> way, I guess that should work too, provided there are no caveats like
> sched is using this info for proper task placement and so on. That would
> need code audit, of course...
>

The only use of logical_proc_id seems to be in hswep_uncore_cpu_init().
So I think maybe we can use this.

However, I think there are two issues.

1) The logical_proc_id seems like it should refer to the same type of
structure as phys_proc_id. In our case, this won't be true as
phys_proc_id would refer to the "socket" on AMD and logical_proc_id
would refer to the package/AMD NodeId.

2) The AMD NodeId is read during c_init()/init_amd(), so logical_proc_id
can be set here. But then logical_proc_id will get overwritten later in 
topology_update_package_map(). I don't know if it'd be good to modify
the generic flow to support this vendor-specific behavior.

What do you think?

Thanks,
Yazen
