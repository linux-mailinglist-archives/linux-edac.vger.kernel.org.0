Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78CE269590
	for <lists+linux-edac@lfdr.de>; Mon, 14 Sep 2020 21:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgINTUz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Sep 2020 15:20:55 -0400
Received: from mail-dm6nam08on2070.outbound.protection.outlook.com ([40.107.102.70]:64065
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbgINTUw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 14 Sep 2020 15:20:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zc7AzV/vg+MVsAwupxnBeeNqriE8C+879bJkLqMJ/+A4UmDTOx+xM79v46PjNmXM4/hV2o/fwBBt1zUbfB+q3nLXDTw5cleAfT9eXDqMPxp63DDHHPzZkOoGaLhfJw0dMiSoCvC14EHlaNwFhmI54Yv1p2OcWkU51Nj/xcXbXX+5UADAfhV9LYA2dxCHanhJvMRO7yz9aRToBiD48sxma4gktZc3HReqeP5RfdmCs1KJ5SaBjJMzOcJVooTikrWeyB6GP732+ssNN0V7Rn+SyNiZFpASe7nkGnEVqR+J6ht7VjbrQdf9dAaFM7MCSnJEcJKT1jvmw9TU/dFY7P801A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy+TzvcEzC+QrUZGLHlC8IrcgJWV7wMEdKLKSi369Ek=;
 b=cg4D27+FZLufkStZJZbTHEBt0LcaJ80j+L3R8fFbpHdLgqZSQXemaZQx1qv5xD4aFTqRaUmwUBC9nbfPN2jhemch/wwxaxHvFjdoipnbaIUUBFT3UH7/ZEcfjtoQ88C2qUNqgS9URFU2wkNz2Om7Rs4WaCQrOl+zwZKPEHhgiD80H9O9O1vnk3q7770N5nN7XOUq8jNtcUJk4chmxhIoLY14BWn4dyOgh5V6hEO7cXCOHfqjmzn9MYdWyGShGLDHWJsoDKc7sEtKEcuvQNLQ5Y2hSNKcy+xXqNcibKj5dDZy/X3t6n8Tr88WiboPWC+M4GsNqucz/hPkI+G047U7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy+TzvcEzC+QrUZGLHlC8IrcgJWV7wMEdKLKSi369Ek=;
 b=FOxiVf1Ntykd9/vD+1moBaBMkNdnG7C2f6rPgOZb4z1N5uQHDg8mjDirh5dyfU9tDptjcVw7ueWQ0ugDt3Or0gL6b4EXQlm8Hk6zHyOU8UlJKphQoYSsS4u3n7wkEGRvYqoRzmIgxipxByzPgM0WOR0TiMufsDrlvANUshEdZCE=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3443.namprd12.prod.outlook.com (2603:10b6:408:63::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 19:20:48 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e%4]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 19:20:48 +0000
Date:   Mon, 14 Sep 2020 14:20:39 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 1/8] x86/CPU/AMD: Save NodeId on AMD-based systems
Message-ID: <20200914192039.GA39519@yaz-nikka.amd.com>
References: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
 <20200903200144.310991-2-Yazen.Ghannam@amd.com>
 <20200909180647.GF12237@zn.tnic>
 <20200909201755.GB3014671@yaz-nikka.amd.com>
 <20200910101443.GC8357@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910101443.GC8357@zn.tnic>
X-ClientProxiedBy: SN4PR0501CA0015.namprd05.prod.outlook.com
 (2603:10b6:803:40::28) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.78.2) by SN4PR0501CA0015.namprd05.prod.outlook.com (2603:10b6:803:40::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5 via Frontend Transport; Mon, 14 Sep 2020 19:20:47 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3aadd1af-d9a2-4bf3-cf7f-08d858e34905
X-MS-TrafficTypeDiagnostic: BN8PR12MB3443:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3443FBAB1CEC7A1E0B243D39F8230@BN8PR12MB3443.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XkYqZ+DRA4q/VlTfshG/6I1I42AeQ9jPTt9eh1HIZ0ZhSZB16DD3S5eWC7GPUqY4r9lyh/6dYkAcTaog1YhvjVtSUONpztQ3FG8X7STZpMDpdqGOhYq41ROCy3GO9eT6MYRvWTCp4STlDLb7KD0LpRIBhVIeIFgIEPUnOrrREpxQQYHpOeOen9dbFc1oeBjn0lIeNQ0DN8eG7rbV3z5/Y6wm6lc5qAYK58WF2qGe82km4SPugWQ+DB5eS7nubG1Z4qTjGcQOwRZf8RbiLOMrWrTToYtwwxKWnxCCe+61xzpGeyYsPp+D4szF2TfjoA93jxhCLaCO0n/eWEU4m1E9cQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(186003)(16526019)(7696005)(66946007)(52116002)(66556008)(66476007)(316002)(26005)(6666004)(478600001)(33656002)(2906002)(55016002)(6916009)(956004)(44832011)(4326008)(8936002)(5660300002)(86362001)(1076003)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: QE0/ujmKayoXL1yJ8IO0mCsv66NveURhum8XAXgAxeQWrTz/0ovmVC1nIMKBlbeRPHHCgc1IaE3wfF6jjIKacdTXreId9RjyzqtgTTmLkdNHRj8n7StvFGT+PMOnQEewOVPu5Vha4gbj6aDn77k4bQZcrsCHNPdnNJq0882+l6NOV47eli8h7kyXvNTXFz7tfhXs6SQVnJ0MpQ8xMgHxxfvOSS6cxWAeP25wz2659oC1PnZNXuO8KMidKzIxsSUzu4rO0fknsiRZximw5TBj6uYmbVAtGDBri6pT2+ndX/+n4sNP4foD/IBweo1ETgVlG5bj90xFxkc9Zf5vZRIaXphiV2VKcDP2XBSqFvdeLpRi+zVzUjziKDcnOH1FKFmYyl86UKB2UBZWNK0YFb5FkWTHup2UemAiKBHM9tejuxQmcOURDJ/HMuztLFFvzWgykC1z70YK3eP61KshZf9pYCy2BwOefUnJdrHiHt7VdgzMfDQPFgEjpwott2Foabd9dHxz/HKfNwYTu4OQMtg3IzYFkREdTjio9gUxWqmj23xBLzkX3BkJ39QYIg/zagBmoDR6O0s3FWbNfM54p2h9N+yVp4cnFJYSsPPctToIZnOCSJcnO61zHnHflPKF9pBUtuCgMLyspIl9EA87WvgYyA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aadd1af-d9a2-4bf3-cf7f-08d858e34905
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 19:20:48.0512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4HcfiAlxvGxoM7tiZ9SR2VILMq4P115+WFJ7RQXvBhLfWT5WXtSLKHjlcE5zCHItTwY7KtcJY4uByUo9Ew5Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3443
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 10, 2020 at 12:14:43PM +0200, Borislav Petkov wrote:
> On Wed, Sep 09, 2020 at 03:17:55PM -0500, Yazen Ghannam wrote:
> > We need to access specific instances of hardware registers in the
> > Northbridge or Data Fabric. The code in arch/x86/kernel/amd_nb.c does
> > this.
> 
> So you don't need the node_id - you need the northbridge/data fabric ID?
> I'm guessing NB == DF, i.e., it was NB before Zen and it is DF now.
> 
> Yes?
>

Yes, that's right.

I called it "node_id" based on the AMD documentation and what it's
called today in the Linux code. It's called other things like nb_id and
nid too.

I think we can call it something else to avoid confusion with NUMA nodes
if that'll help.

> > Package = Socket, i.e. a field replaceable unit. Socket may not be
> > useful for software, but I think it helps users identify the hardware.
> > 
> > I think the following could be changed in the documentation:
> > 
> > "In the past a socket always contained a single package (see below), but
> > with the advent of Multi Chip Modules (MCM) a socket can hold more than one
> > package."
> > 
> > Replace "package" with "die".
> 
> So first of all, we have:
> 
> "AMD nomenclature for package is 'Node'."
> 
> so we either change that because as you explain, node != package on AMD.
> 
> What you need is the ID of that northbridge or data fabric instance,
> AFAIU.
> 
> > You take multiple dies from the foundry and you "package" them together
> > into a single unit.
> 
> I think you're overloading the word "package" here and that leads to
> more confusion. Package in our definition - Linux' - is:
> 
> "Packages contain a number of cores plus shared resources, e.g. DRAM
> controller, shared caches etc." If you glue several packages together,
> you get an MCM.
> 

Yes, you're right. The AMD documentation is different, so I'll try to
stick with the Linux documentation and qualify names with "AMD" when
noting the usage by the AMD docs.

> > They could be equal depending on the system. The values are different on
> > MCM systems like Bulldozer and Naples though.
> > 
> > The functions and structures in amd_nb.c are indexed by the node_id.
> > This is done implicitly right now by using amd_get_nb_id()/cpu_llc_id.
> > But the LLC isn't always equal to the Node/Die like in Naples. So the
> > patches in this set save and explicitly use the node_id when needed.
> > 
> > What do you think?
> 
> Sounds to me that you want to ID that data fabric instance which
> logically belongs to one or multiple packages. Or can a DF a single
> package?
> 
> So let's start simple: how does a DF instance map to a logical NUMA
> node or package? Can a DF serve multiple packages?
> 

There's one DF/NB per package and it's a fixed value, i.e. it shouldn't
change based on the NUMA configuration.

Here's an example of a 2 socket Naples system with 4 packages per socket
and setup to have 1 NUMA node. The "node_id" value is the AMD NodeId
from CPUID.

CPU=0 phys_proc_id=0 node_id=0 cpu_to_node()=0
CPU=8 phys_proc_id=0 node_id=1 cpu_to_node()=0
CPU=16 phys_proc_id=0 node_id=2 cpu_to_node()=0
CPU=24 phys_proc_id=0 node_id=3 cpu_to_node()=0
CPU=32 phys_proc_id=1 node_id=4 cpu_to_node()=0
CPU=40 phys_proc_id=1 node_id=5 cpu_to_node()=0
CPU=48 phys_proc_id=1 node_id=6 cpu_to_node()=0
CPU=56 phys_proc_id=1 node_id=7 cpu_to_node()=0

> You could use the examples at the end of Documentation/x86/topology.rst
> to explain how those things play together. And remember to not think
> about the physical aspect of the hardware structure because it doesn't
> mean anything to software. All you wanna do is address the proper DF
> instance so this needs to be enumerable and properly represented by sw.
>

Yeah, I think example 4b works here. The mismatch though is with
phys_proc_id and package on AMD systems. You can see above that
phys_proc_id gives a socket number, and the AMD NodeId gives a package
number.

Should we add a note under cpuinfo_x86.phys_proc_id to make this
distinction?

> Confused?
> 
> I am.
> 
> :-)
>

Yeah, me too. :)

Thanks,
Yazen
