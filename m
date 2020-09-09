Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEC9263733
	for <lists+linux-edac@lfdr.de>; Wed,  9 Sep 2020 22:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIIUSJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Sep 2020 16:18:09 -0400
Received: from mail-dm6nam12on2044.outbound.protection.outlook.com ([40.107.243.44]:60993
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbgIIUSI (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 9 Sep 2020 16:18:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqBxbhN2N15haQJ8jhozDZf2G7Nhk0zZYyWo/CUW37ScyalEDtSafmv1ashgFPkZ/N2+6txF5Qp16jTeOxuEe7WdzCnDg6n3BWNY1U9ac5cLgiODjOajKGuAHuIMNjbOsi+EDDJu5lRZ9WnzP7GU1DeH22DTfG5j+HLZ6Wh25QJM56jM1MS5lRXuQdI77EKmEA+7suiqi9mK0bKcZKtcE2gdDNKog12lT81NV8SDe9KcEE0WN601U74YGfB3/JdXGuEfrzN90PAkf/u3dTtwzb3XgZA1YHrxCg35oQeMe1B6vy2HfLoc48730kYObFnbrSNTcfEivKIK7txoh4uJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=143oLX3hExMu9NK7Wt9PT5xIHd/cdcmy+b8gjUCPwxo=;
 b=O5NGHhaKHwVtPyglaEUmfRWEf8nfFK1uyg7gVYuffRZZY1ZKYZ22Nyc8ESFu13nGtkwIIlc+NuskxErOmyl+5AIJIBXx5L3UIfKAJw9fT0s/VJoCYKpG5QEDglS0PxXnQAL+jETtY/ijYnctV5xQ7UT0LFr/I2PE/QESd5wB2UNFdVT915qbh1Cqd3tS7Y8GaHewkUlqn+6h6LPi227aW/iSvpMM2HZpI6/yQUXALy5EZlqufK3KfiAWgLKmgIi7osP/hEHkbjbX8C6QZ+UtX9UwmGFW2oSPsWh5/eO/RvihnLBlIX3VUEFHr29D8XAbR9EG2UR3tQSW0pYrljieKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=143oLX3hExMu9NK7Wt9PT5xIHd/cdcmy+b8gjUCPwxo=;
 b=kUho1ZQ1WVnhJDWbWy4g+SpO5CzhnbjgHUE99+qUvg92JVLoaDOagy6UsI+90yF9xTeZNDf/ggBxGCr/ftV6h+tEqboP7nChWMuLVDrwyZmvn9+X8xwyPTf2bEvXolhaFd4wInAvQ8QdHTo6k0/8a/foIHWLAVzy3TkmJl3GED8=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1185.namprd12.prod.outlook.com (2603:10b6:404:1e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 20:18:05 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e%4]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 20:18:04 +0000
Date:   Wed, 9 Sep 2020 15:17:55 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 1/8] x86/CPU/AMD: Save NodeId on AMD-based systems
Message-ID: <20200909201755.GB3014671@yaz-nikka.amd.com>
References: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
 <20200903200144.310991-2-Yazen.Ghannam@amd.com>
 <20200909180647.GF12237@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909180647.GF12237@zn.tnic>
X-ClientProxiedBy: SA9PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:806:20::32) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.78.2) by SA9PR03CA0027.namprd03.prod.outlook.com (2603:10b6:806:20::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 20:18:03 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f37c2ee8-3df1-4009-179c-08d854fd7535
X-MS-TrafficTypeDiagnostic: BN6PR12MB1185:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB118592DDA916362BA8D4267EF8260@BN6PR12MB1185.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ebkeI4XbxUDQ3Y2NcQ+xL6lQqPCZ3l0nmkEsrLBohSBLfFNfboSSMRdFopG/tGM3XVl2cb/g+j6BovZYgAwjnmsB2uELbk34m/lhxB9VV/iHbfmj+JTSjnOAXbM/kFNTqFNMPACFm6iKY0vFVLEqxC17d3q1WNJl/pi1yW+M1D5iZmyygf94IRZluBK7iNKo1g1Bqr6AIkXJGlPB6w4Ti/bhU60F61iG5XE//eVfVyHQ3K6O8BWhQt0UCMFCT0rs4GGt7mvhyHYVcPsffvBslP1FwK+xznIKicRiYpdwgepGIy8hwkZq7neA7IzyMObjq3F2dDgn1JqQhBLbsf2dCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(86362001)(52116002)(478600001)(7696005)(316002)(55016002)(8676002)(1076003)(8936002)(2906002)(6666004)(83380400001)(4326008)(66946007)(66556008)(186003)(956004)(26005)(6916009)(44832011)(16526019)(5660300002)(33656002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3cqQOxxDEFYJeXZDbitYUeuwzsnuEvEq4FBwKS01slBx1mtgZZm+hMUkgouBp0nAiTHXpNdLm5Fn31iG3iqDPJ33Tk17eSelerw1UE0ETm42/4vp5WLYmC/0e5zsgK6VnqgjHaja8SlwoYycMRyoJ16GbOJbUAxnIgfCaYGJtcxDFh7P0B0mH8nTsndl0Dv8MMuWgQWGoArrjFI4dXn5Z+4xkGitNyG6O78eMBiSe0TBBl8FiRYoGpKt4IZ3yMYUz158Ruqowh6kK/wtq8mADQKZYK0TUjqsKqIAnnwkU/PowXb55p2brYTRu9UZuLeAl7kV9OJUAOkgKRu/AmvVybECPXgcQUAbirKRj8i3PPra708EaQj0wd5BgS2X/601oy4RLVAW7+jVNcpCEV5Xlz2rmmEgpmERsmKvDcK5Z+JlznkSkBQAxshIms2ytiJ4Kcr1C+9PS38WUq305E/nH+1wmBJHblN7+JWc8aOPIlmYMjq5FTQdLCogWhjpBRiZe7HOjBZmpv6mlSTq4qyFjnDZE9Qw51/u0qvMEVJXQdv1v7nwVDZH20yeODa9xEj/WUJWd1hqxV3SMYWwi/d0yxaopKWhKTYdDh/LafqVLp0ApUwZ9fDVN501vwRhXOJR8QQKT6C0x1wDAwhIYHbEDQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f37c2ee8-3df1-4009-179c-08d854fd7535
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 20:18:04.7055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZP/W0oQK6fvFhhbp25zNhHsjosV6UdUrQkzLg0fecN97ixac7/jZFRLc6GBDNVwXGvjRcfCeHT8SJ0/6ge+DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1185
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 09, 2020 at 08:06:47PM +0200, Borislav Petkov wrote:
> On Thu, Sep 03, 2020 at 08:01:37PM +0000, Yazen Ghannam wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > 
> > AMD systems provide a "NodeId" value that represents a global ID
> > indicating to which "Node" a logical CPU belongs. The "Node" is a
> > physical structure equivalent to a Die, and it should not be confused
> > with logical structures like NUMA node.
> 
> So we said in Documentation/x86/topology.rst that:
> 
> "The kernel does not care about the concept of physical sockets because
> a socket has no relevance to software. It's an electromechanical
> component."
> 

Yes, I agree with this.

> Now, you're talking, AFAIU, about physical components. Why do you need
> them?
> 

We need to access specific instances of hardware registers in the
Northbridge or Data Fabric. The code in arch/x86/kernel/amd_nb.c does
this.

> What is then:
> 
>   - cpuinfo_x86.phys_proc_id:
> 
>     The physical ID of the package. This information is retrieved via CPUID
>     and deduced from the APIC IDs of the cores in the package.
> 
> supposed to mean?
> 

Package = Socket, i.e. a field replaceable unit. Socket may not be
useful for software, but I think it helps users identify the hardware.

I think the following could be changed in the documentation:

"In the past a socket always contained a single package (see below), but
with the advent of Multi Chip Modules (MCM) a socket can hold more than one
package."

Replace "package" with "die".

You take multiple dies from the foundry and you "package" them together
into a single unit.

> Why isn't phys_proc_id != node_id?
> 

They could be equal depending on the system. The values are different on
MCM systems like Bulldozer and Naples though.

The functions and structures in amd_nb.c are indexed by the node_id.
This is done implicitly right now by using amd_get_nb_id()/cpu_llc_id.
But the LLC isn't always equal to the Node/Die like in Naples. So the
patches in this set save and explicitly use the node_id when needed.

What do you think?

Thanks,
Yazen
