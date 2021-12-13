Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5BD4732D3
	for <lists+linux-edac@lfdr.de>; Mon, 13 Dec 2021 18:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241259AbhLMRXN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Dec 2021 12:23:13 -0500
Received: from mail-bn8nam08on2070.outbound.protection.outlook.com ([40.107.100.70]:20481
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236018AbhLMRXN (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 13 Dec 2021 12:23:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYC46wp5ROc4kfFcEbD5rJZ1eI2rPVuiwkpM9VoOwWNE4HvqWQ1AA9L603O03QnOy5FdVVYmT7iBQxbCg5JCEXUSEciy6fXCEt1IQRv59q9K9K4l0BtLo586TTE7DSIyKvOobMWdQXXgA41jzjeH2/f2J6/fvemySKPSDKhXPtqnVYMbt41Kels8DETCeZNpJZjJpHLu1ZV8GZWKJce3/et0ly8av4Lb6Cu3Tf1E/fiH7TR2X83UPilgFp9LLvuT33O5xdIDeXfzyA/k3Dvzkt275THT6AasDsLcpjAQRDt3Rg3ap5Gc+64/lIlmGaZAoG4+kZ1X2MfHz7MPHIWiow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiMa4iuduZd2cgF8eBofGBQh4CjrKZwVa4K3TTikrxA=;
 b=bivSCA7HGdQG5GCcsLVZw9SYVW/Wxr6eKurp+zV/ECx0e9npEjRu3C9sUF4oqDLYr4Xz/Xf5pw+tGSFFXfCgjrjOsKY093PDFWLzVqCiMN8/crUyhFr3YXBMjlCIxeXS3FXxwmLPREDl2ztxRlD52q0U8QfoeVFCaUsyWagNpdkCUFL2VG8W4NoYmqq9C0MddWuAdYwqF3RnH3O8wytaw2AcWKRJEYxLM72mpOUrrQBHowx/aIAflbD+j10iNBpYHsp1trzMo3gm3adGih1RkB9WhHTZgRhTl1ocR/U48X0cpRtpxiXegBHHMMsU7phb91T0hN5AQFbhirqSFLIimA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiMa4iuduZd2cgF8eBofGBQh4CjrKZwVa4K3TTikrxA=;
 b=kk9+s1mUOg6YH5SLmIpL8XlAncFhvgLS3hoN19AvkZytZE9BohJW6wKsXH6kv8d9r6hDu2F8tRgZ4GdUyBU1kdcezM0k0QBhNifMq65jt4qCkP6UEwm+wzuddr4rsIRUlEAaiREtn9LbrzoIjmVWw9caaGVrvcUIlBYAkdxrVNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2945.namprd12.prod.outlook.com (2603:10b6:408:96::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 13 Dec
 2021 17:23:07 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a192:7073:258c:28b3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a192:7073:258c:28b3%6]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 17:23:07 +0000
Date:   Mon, 13 Dec 2021 17:23:02 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com,
        william.roche@oracle.com
Subject: Re: [PATCH 0/4] AMD Family 19h Models 10h-1Fh Updates
Message-ID: <YbeBdqer8Wh3KiRd@yaz-ubuntu>
References: <20211208174356.1997855-1-yazen.ghannam@amd.com>
 <YbNLm5+HsrDSEULp@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbNLm5+HsrDSEULp@zn.tnic>
X-ClientProxiedBy: BL0PR01CA0023.prod.exchangelabs.com (2603:10b6:208:71::36)
 To BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9057e938-92fa-40e0-4263-08d9be5d3a21
X-MS-TrafficTypeDiagnostic: BN8PR12MB2945:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2945C887522CF03723782864F8749@BN8PR12MB2945.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JGcY3q2P9jWVLvQRjaSxAEP8pBjaXdRQYQt0JIsdDWzEPZy5WSC8p05aL+dwi9fD7a+bOJO9sXbnk5KGx1eK0Eq2OyIbGMwVleTiFVn2fRZ/LNqkew+O/VMhhk0RA9J25oKnSuSHqEtyYl4AktPNFHJV2thOPSGGVVlak2ER0MaZSHcI4GnD0Zm1EyFSkzAed7vxrwQTTtqihM4E3fD5UO6bjeruW9TgDoMHnizmEfoBMKfZlcba4Il88ivWUxkmN374ZJGK1oAjrHdbbz4h2erhldMLTr3Mx92SNOLk0rgUH+028MNsepJKL/Fg6cK6Aw3MD3yrxnodX0gTykYYhX8+g8Rpxi6IKmSqXRNRnDLCPHbeJx8qCh2hcL79zEA9kHIcQmF1xZVi6zp5gpeVqmCClKjVbIdyGWB75qNczOh1Q7oBkTLmUOqiABrgI4tzgvQepw0qBbloLaHwMQvhjN9IxbhXOPVBxNAdrVCSWIgmAQ0T5UJw9TQhr7kkQtoSse8N+UzktIjX/wfhUesUiGYuhURc2Ab6wx2n5oDWMiRtxKNaMBbXeq7no/f+rmnVk8pCAnDg3NdBapqqCDuB69XKHewbhWhtrfSLRgk1Ze3CT6HqbMl7gYAK7OdUdE9gBt3M6a7A5OSOj9EtnCoEgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(6506007)(2906002)(44832011)(4744005)(508600001)(33716001)(8676002)(38100700002)(6486002)(6916009)(5660300002)(8936002)(6512007)(86362001)(9686003)(6666004)(186003)(316002)(66476007)(66946007)(66556008)(26005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UprcKCkZmCzpYObXh+YOAGdLiwKCpUF8ZcvgSd6swaF9TZFTH9nLlMfiKIMK?=
 =?us-ascii?Q?Z7pr9mzMIcSu9iTAIbkQl6bI0uNG2Y94so40rm3fil/PeHYf8Pp/gVLZFv5r?=
 =?us-ascii?Q?yvq1gXmFs4Fhof3JPhcJuHaew1UVq+BMvn82U65UGn/makOxRigq2exzmO4J?=
 =?us-ascii?Q?oGeC2M/ODSu78BvW6l3mT19HEt1CNbs9jhQ8rL1THL0W9vuKvRyXAXZvOb5Z?=
 =?us-ascii?Q?Jof95QMY8o5VRfV0nRHSAjeqDwyUhqDuWkbT2tENkS3EbewcJAI58ihCXsxc?=
 =?us-ascii?Q?/FMU5dEEihgvlR6zkI3e78AGPc/2BRHJ53sqwjmIUqUXyaCtPj1qlq5k1dI+?=
 =?us-ascii?Q?aaVMsfRGkJRnqCeB/JaGKyRXnhq+J05eMxNXpyZML9fMG9P1lJCLubJAsRUL?=
 =?us-ascii?Q?iqsA3fiO3k++dD8YuAmckXxET8MaxXMepa7mKi4AW942S+t+8VYIqmzZRi0+?=
 =?us-ascii?Q?wleDY+578BK+1qc4P4PB9WviqS8ag42W4pHSaoJh90gDw17MKn9nKGKRzAg8?=
 =?us-ascii?Q?GF/fkKfPtiRQAYhkK30TU8sombtRAtw+aFmWsVSo+Im9KTbCMXDbtf3+u0lB?=
 =?us-ascii?Q?ge+uFu79pchQuWNinUqsUaO/OB4ITDddygna2r9IRXBSh93e0AhTA4ya6yrj?=
 =?us-ascii?Q?iVJnKrHP7IQzY7/dFpNZzHCmHfcmjAOMX37NeYGvK2pp4wEP9j457zQyrxMt?=
 =?us-ascii?Q?Qyq6A/Kv2GSiwZF3j4k59WymtIy1CQ9j1ym3lke838hPJ4jonF7FnOVjfYk0?=
 =?us-ascii?Q?FMBy8yULNE+XhwBF+o1jJkJHIHSnRvloT2IkAC8lOZK6jAlh97cSldyBtuQ3?=
 =?us-ascii?Q?mR113JZaNyy9gyd2n59ljAkw9iuoxO78kdf01G1qQ4HHGZw7fG9bQ12JenZw?=
 =?us-ascii?Q?lbCwbR1KiPqBseV7BzXTTm6pJtmoT4n8upEn2CJcP246iymEURmC/W4/6XXl?=
 =?us-ascii?Q?tvfRvKys5x10zQNTfr9RMQM0HNtD1GVW3pzfSiXgX6Ten7lL93C4emm6AzVK?=
 =?us-ascii?Q?YmwPOVQB8Yefj6o4hynpcpnJ75Cs/VvbKs0SZRPO+ExDVmbJa6jNHBjclOH1?=
 =?us-ascii?Q?BCOjHtgZD5QxpMQK0M+hrR0hp3IlEyTSp+wwNUt6UmvxTWUfy8Aik9OUfCFj?=
 =?us-ascii?Q?jxit6tXeSKhEG7fjbFh4Fluqf/YAz3PVIXOV99jHagtHFHk2EvVbRQju3SMA?=
 =?us-ascii?Q?gt1jYFH80dJLYarUG9Dxn1b57bCLXdC/mjv4OOTeOgN9WpnsIOMjyCov2PAH?=
 =?us-ascii?Q?az869RfKwe8syFmeTbBICENQxZJILagrR8rORCKuFcwcxQXP3KkXYKvDoQf2?=
 =?us-ascii?Q?mz8tOsylDriEoKSDaSRZ/JBzYu+r5rtTAO6PhVItpGQbZArga4VJtuxLZH5+?=
 =?us-ascii?Q?4ajUohbNt4o1bFZUZj3eHwW5m3etw0Z4Cek3CF8F+8Ki+dw7H2A86Tyf87Fa?=
 =?us-ascii?Q?9AJuQCM9qjdTvaE/df4i8dlHEhOzx1Fy+OJ3lQKSYDlmalcSRR51zhcnGwCB?=
 =?us-ascii?Q?DfcbpkMPHBojoN2c2N5RwosQ7i9rcVqGhMbWzD+nJcCnpflPjGVpmCcVfE7U?=
 =?us-ascii?Q?/LRQ6Pl+oKqsr9AdgKN4/LpjuGUWnYVR38ZmAk1Pv/KT4tAYJlVq8qgDcuHQ?=
 =?us-ascii?Q?JVU9zNoB/GmvhXJuIRWhYVs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9057e938-92fa-40e0-4263-08d9be5d3a21
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 17:23:06.8317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pLT1NKu37mXrq0jE+ssbSBYWwL9HusaiylosiKC7KkDwtTNcnUXXtQaz4kLWPL/DMtd+Xn0Ip6uWCveYENQvwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2945
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Dec 10, 2021 at 01:44:11PM +0100, Borislav Petkov wrote:
> On Wed, Dec 08, 2021 at 05:43:52PM +0000, Yazen Ghannam wrote:
> > Yazen Ghannam (4):
> >   EDAC: Add RDDR5 and LRDDR5 memory types
> >   EDAC/amd64: Add support for AMD Family 19h Models 10h-1Fh and A0h-AFh
> 
> First two applied, thx.
>

Thank you!

-Yazen 
