Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70B754CA4A
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jun 2022 15:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241332AbiFONv6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Jun 2022 09:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiFONv4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 15 Jun 2022 09:51:56 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2052.outbound.protection.outlook.com [40.107.96.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5474F3B02F;
        Wed, 15 Jun 2022 06:51:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAS+u5ZWHiSkgiEvPSyU+M9Ej6YIU/AU93Q5uc6dN3VL4EeQBmo5Wlr8demXGLPFa8k6Wj7NoBFgOgaMIcfU1tWXDgVbx4Q+QN59O0hrpqJpLTwk7e++4ylSqGte8Nwj3Tj+EHbkRsRs6uqBWm9xGghOkpTIKhJqbzVIdyJlUaJE/Cx5GtRyvwGQiQb5bBVxQbowrORNkqMJsRIpp0TbLHVIH95F2G7Qik0KYuJJjycz8zgkgWwRKscsm08jFeoiovLR9LkCuIIckGM0N7HW+qbFLQ6oZFd7NOIyeKIlGfmr5w3Ee79bgnfbQWp9rE5iskzN+3RLNXvlf7eW0SGPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sA6oyt48guxhP5U1AMzyg/AuB2mo39Cq0C1w0spPdAw=;
 b=dO4z18IxzlhroLXNdaJSrcTi4c8CiL506aJCEForANeu9+AhsLwj4uotupr5ec2E32f7Mk8rrxHfAJ71o59inFPrfWuLWo/y0OtUEByPQng21mcxidUBb+KK8YDhg+qSxJZQAnfvaigYsHdRre0a/Cd/0eFt9wpqhKnJtVWGkcyZK25wxLNa/oWyK/VZHznsOJ5bCf+F9LdaEc+8QMotKOTjKwmjdJvhj4DlaMK80hqxSqh+9vyMu2IT3yjjMUJTTmKGWPfbwq+nbITkXygNr54xv1UzGDHaP83WelXojV0bAZGVfDxMhc8iX5fG67+O5J5BfC/bM5lUf7z8jekbSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sA6oyt48guxhP5U1AMzyg/AuB2mo39Cq0C1w0spPdAw=;
 b=rc5ET9hATb0BRZOdVsVeI5vrM+BOKB6kQdtMuT+zx1EaoicS6zFyR/59cK3uqqm0BANCkMZcINB98g1bKRfbZuIv1JAe0mQiCvD/Q8Jnd4pgGepM5LVgZhSoFUkTRekkXbR5qEDlpfr/bAIimCmfgeUjEvCGuaFEVUYeaMd0+y4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM4PR12MB5296.namprd12.prod.outlook.com (2603:10b6:5:39d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Wed, 15 Jun
 2022 13:51:52 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9dfa:d871:2068:662f]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9dfa:d871:2068:662f%7]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 13:51:51 +0000
Date:   Wed, 15 Jun 2022 13:51:47 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, mpatocka@redhat.com
Subject: Re: [PATCH] x86/MCE/AMD: Decrement threshold_bank refcount when
 removing threshold blocks
Message-ID: <Yqnj88FPkZ6kBU7k@yaz-fattaah>
References: <20220614174346.3648305-1-yazen.ghannam@amd.com>
 <Yql9TqFtebd2h9Z9@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yql9TqFtebd2h9Z9@kroah.com>
X-ClientProxiedBy: BL1PR13CA0373.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::18) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 306517a8-b20d-4c73-a935-08da4ed632e6
X-MS-TrafficTypeDiagnostic: DM4PR12MB5296:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB529642B7E80CD0B74EFE2E58F8AD9@DM4PR12MB5296.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qEiWayuTkProME2Pw6NVT0+3KqeKDF4hULPvTl6vSiM/VXkZwWrXFbLiFXIlcfnrjzkrERE0Wrlm/vkHAO2kKRe+X2KT1Y9eOb/3kFGmG46TCz2K6MkNQuuqU3wTrfirelRepDgRizdGmEguhqZSK06TzdFkWXPyaZ9eCbJnGWqE3sFRlr9ESLKP0OgEzhH6oBP4ZeTFj6JGHjfbbsB4uZaHf6UTnn7/lEJzdP8MKRHGGEGaJVeSaybGWKA+5Dn2TnuTvg2+lkrEWg/KF5NKr6hE/k7lmRi3+m+qV/QanGne1f5iD5PppzVM7jSFSRSyoRPBZbdGTxxhmRpKsCiiRffVo4noCDxkyelgKCaI+Dol94C2RrI0G16OOPrgTwCJVyN+m2Zk2TbCN8DRAOVPLsosEsCVsEZ828oxSaEZeV+q42Ov4TIfH36NW2rjVaVxEAN92bRjyDOj+irPa/p4E1fjzpGHSLPQUT/qSDUb9VmZx5jurcDwnHpPry2q/+VWVUn9dvswYUwZ5mECFhRiVqr9COMM+TpSCJeAwAZv9AVtT3YpjzGVmlYQgNZdGqZVMRQy7ET2OJrd5KYoigJzeeLB7mWzJSV/KNAtokzPZhX/6bisaQEQo7zwCH/1CkJBwPel5TDsGCGTveSOGtNZNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(66556008)(5660300002)(8676002)(38100700002)(66476007)(4326008)(2906002)(4744005)(44832011)(8936002)(6916009)(66946007)(83380400001)(316002)(508600001)(33716001)(6486002)(26005)(6512007)(86362001)(186003)(9686003)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IsCQj0z9k4yA4O+oOvoY+IgXvcrQmENZZdHvAEv7S487/T4yTAZYIOidnr6B?=
 =?us-ascii?Q?aqXVjdPVNrpSwPqBnD8penGpFl9PdgVMNsaTIbzLjy8ZvJuyXObXYKJoNJ+d?=
 =?us-ascii?Q?/AR2/7VzcFilmPf/N2ieL3mtDGrcbmolLDWoFRiUxYj0hZ/13K819MuIr0Fz?=
 =?us-ascii?Q?xD779GMD/4aNpIrH1CAmA+uMOA3UC+zk65n3DiF1AMbvE9aqpOapKjdU5H/+?=
 =?us-ascii?Q?8bJsE7/FAhIhbU603fdC8aQ50rMqFTXT1phgxFzkr4iopexCHt4mXYox+mfF?=
 =?us-ascii?Q?ABwMnGUZs8bIClOZHEQuMAx+JiYNqhGwepAQwOgwzTV58mkj6F3rd1J5lVgd?=
 =?us-ascii?Q?TDBA/7aDqE8zgDRVDJII9fIyXlPcA0yD2v5XhJqYGVUrprE92knGB4IsM479?=
 =?us-ascii?Q?nIGDQ962q6GGGaBQLBPLHtzEeKT6TwZ4wF5y7iyCe9DNRAzi9vBOaK1VROsp?=
 =?us-ascii?Q?zlXTrZ8GY4h1ZKToVYwux9sQsGfn7FLMfU5XByUcTkdcfB8D81JUOCqwKWa0?=
 =?us-ascii?Q?3YS1gPesY0gxNMDDhpHnOv1TqVFxDf6QDX46iodhtcrphxHLeSJB8VE+Bjz6?=
 =?us-ascii?Q?OlgOXxqgMIx/c8ecVfqRQjvkYxF7ng6aBaOBizFdy7sr+rrz6ffFvZvoxWAq?=
 =?us-ascii?Q?nm2s5k1un2uprGOZFq4jtpVpdoE2hB2KG2EU6Lb7zrU4fhN0U1MgWCyfWjd+?=
 =?us-ascii?Q?iKLZqPFCkyYArpN9ho5ASinfm4/Q4i0uv7+F8LyikhgS6MEFR3ckpPxpMaLx?=
 =?us-ascii?Q?8bFQFRlZpZl/TN8ALE///CWZbo0nNMlvPaOD52RV95Ro0aZbkvrQoWpy8TN8?=
 =?us-ascii?Q?5oNPjwx7qwhzpeJN24tuxLygVS1BaRV9i04HriNDyVeGdr5jNSdBpWw8JQLD?=
 =?us-ascii?Q?CGQWCEOWFfKwVK33ihr/QPxdD4saI+qmYpkb07STJuqXv9MJrXUC5qwWHKH7?=
 =?us-ascii?Q?K/4azkl+TY5upcKzZPlDIDE16GrR9CTbyPp3uCM+m92elQhVNolwiPVBMFu/?=
 =?us-ascii?Q?Oa0UlZax3yz+rQQ+VRLwSjlWI2+rOlo37yLx7njquNaf8jVFi51dETcAkbRN?=
 =?us-ascii?Q?K0dAck0XqtoDO7/MDs6dKD644cA9O3qd9JuXHbzuN0G2ZOtQDMJ0YEL83n96?=
 =?us-ascii?Q?50Mf8qjU63nPso0aTKe3hGnrQ4p3tbx/WaHBU88vuTNHOVeDttxEnCZawDvZ?=
 =?us-ascii?Q?XcG9JZiNbaLzR7YzF15rdWmV5F4ccGTweu1F4GQrt/vjl7yoDnE/50eOY4Bn?=
 =?us-ascii?Q?1/O6Vm6CTUNM31qbWIEKUWTM7pXBDBuz3N6uw0gb/Ep04EhHnStregACHXpC?=
 =?us-ascii?Q?V4o9Tsx1jRCKAw3vymrh7PPbClxLSABXKLn7NBRWzRH+Fg3tCOJ4PUZy4YjN?=
 =?us-ascii?Q?kiNKj2OsSbHAiCvtiTu9dlkATQzbfrT7/y7aPa+QzIRfcxvyEh+g4KUI53E7?=
 =?us-ascii?Q?oJQR5iqF5hiMlzeG4lEqSI+84Zg3hSy1lEzLtZX8LK5m7h3UJpH0WkywFf/s?=
 =?us-ascii?Q?4/6Kod9FLkkquKCv6JWX7v/JKHOEqJpuVDFlxm3MfHBxVlccW3mIrDaNUpRb?=
 =?us-ascii?Q?J3/VmiEixes361G2O3LD2FPrTZR95S2YLfxNoRBgbNODAZGEvD2oemjR8RtC?=
 =?us-ascii?Q?hbxtlHNeni/U2tBQ9nVeyZAGT8mUAPe5Zj2aQzlOjhxglFCuZRCfbR2nWcdP?=
 =?us-ascii?Q?L5gFbki4tHYyVvNZduvYHzs3wUBTDf0W9NVK7oB5+lJpM5L6DLfftkPLPBPn?=
 =?us-ascii?Q?pBYNyuWnPg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 306517a8-b20d-4c73-a935-08da4ed632e6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 13:51:51.1385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: joDjQZHKi072M8n09xJry4EZdAjcoxCfG8kiAgXJEVfFEtac2yzJDZ6wJtvmtKB1PwW/12D1JWP2HKlBu5BMRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5296
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 15, 2022 at 08:33:50AM +0200, Greg KH wrote:
...
> > 
> > Fixes: 7f99cb5e6039 ("x86/CPU/AMD: Use default_groups in kobj_type")
> 
> This predates this fixup, this commit just exposed the root problem here
> so odds are it should be backported further, right?
>

Yes, I believe that's true based on code inspection. But I'm not aware of any
reported issues in this area before the commit listed above. So I decided to
switch the Fixes tag from what I had before (shown below). I can switch it
back if you think that's best.

Fixes: 019f34fccfd5 ("x86, MCE, AMD: Move shared bank to node descriptor")

Thanks,
Yazen
