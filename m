Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD28A6C86FE
	for <lists+linux-edac@lfdr.de>; Fri, 24 Mar 2023 21:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjCXUoi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 24 Mar 2023 16:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjCXUoh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 24 Mar 2023 16:44:37 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492315B88;
        Fri, 24 Mar 2023 13:44:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYZHIasl0URvN9FVKvf7V+YCs9LF/RR87HKbbhYC3PKvZVi3oaY/5NWaajbPlBa0wUNCnDsv/F18phtKr+DX1V0CKjymBq7L94kz4ADsLNcaq3SCoV0TUpe59wrj6tX2/WxW7L5O6WOCBdr8es6elSda51cMKa0HEqHdRLKZ+1kEla8WBV+1a43FJFHE2X8+tMfMos8aUw3IGRgJC80LE53OnnNY7R/1F9lsj6YVeT05/ykR+UqH9aOqT7rHoy8cdbCLIwjUSsbpDC2U/jsuof7+Fyxrs4ehds8+E6j/WN2FOQA0yCM6xwveIX4ALSZCLZZnk4Tkj8Musvj+s/mPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7qlSzI3CwccZe4ADQLthW382+GxDBl7H5M+Bi3x8VU=;
 b=Cv0EBDjBGYFCOc+V6xfmUVFnPOk1Qt061dJmx1+ZVAu7fUjFC0mLv9X84njaW+L7Z5kz71x2N6BVvQT1zwoxEDZf5kSZ5/PYA3uSpfYDA40hNnwDLdqvNoDBROxGFvgVvg0kWh4AykKwG5/vIl+JkrvQN/J6gE6tUo9I+IHd5K0I7JdmAI/0PgAYv2DK7Q4y1yaqZl+us30JXoI/N+HEeRQWhnyhZjg32gHoid4d+opDqrlW1jguhEpyFKhJ1qwxpFB0MAtTY7pec+U+7f5naD1VuGHp8VxpUBeGy1R5btox8vnE1EkI65R3RJkq5uwpjfN4pH+GTZMQTnsPmRffVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7qlSzI3CwccZe4ADQLthW382+GxDBl7H5M+Bi3x8VU=;
 b=5Wmq8DWFS3c8vUJkvDNFKlHwQhWYZPhDOB1yb84LTmthtQW/FotRcpaBiPU57coWQfpeInl1iQ1JQjL18y9Y9g4aXxswI4ioUOboxNAVzuysO/LuyZWmo5lZFmwCZP07ol9OTgt/BpfXckjg6ODPE96MBSE1nbs2rmL4AFXUZn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by IA0PR12MB8304.namprd12.prod.outlook.com (2603:10b6:208:3dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 20:44:33 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45%6]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 20:44:33 +0000
Date:   Fri, 24 Mar 2023 16:44:29 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v3 4/5] x86/mce: Move storm handling to core.
Message-ID: <ZB4LrQicDBzdBTZi@yaz-khff.amd.com>
References: <ZBR+GMH0olGoDMGs@yaz-fattaah>
 <20230317172042.117201-1-tony.luck@intel.com>
 <20230317172042.117201-5-tony.luck@intel.com>
 <ZBxvyqb5Mnt13341@yaz-khff.amd.com>
 <SJ1PR11MB60835D7F85097FEF454DD74CFC879@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SJ1PR11MB6083D33BC6860AB9FE2A292BFC879@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083D33BC6860AB9FE2A292BFC879@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: CH2PR19CA0014.namprd19.prod.outlook.com
 (2603:10b6:610:4d::24) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|IA0PR12MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 26956dfc-3293-44e6-228b-08db2ca892d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dtoaWZDECw0Uf9X6dVLKUStA16GcBzEewcSYSIEdpwROutLrvtRz+RxcSnFTb1lUhA0CucsUJFIA6D9xHcyVVH9/mGMyaHoE2/x0aGUES0rKqcnBkYdwzICUVSKNBFWjsRaet8Qs3/Casm0sINtAR/Dp0JeIyg+2zf6Hh0tDfl6FCACtpyfDpexJujrltf0rSpYevV67/VJ/HA3WvAsu/76+F+uWiGP2gyoxVGOdvK5WH4ziW9nRYp8SzR1Psxkm0ciInLOoVAX0beMiKItEdC8np+STppgiJR0GJPDZ3RMlOfbKhONU5ustcaGor4Ql34rnc40cREwzYrT8F0zM+8yPPk1iqQz+6XJ9VjXf5IblWHIeXIL4WMF/Wrpl53QVCAWzA22KpJwlWkIqk2LxIr6EWrRXQ2VtYkygiRFh+c5EUn47YhjwC/m31VNmjmZPM0yBPV+/2hxC3TSFCfK/c3nU58qfmw8OOcltWwOXsCEjR2gZloMJ33gM4dfwca+Am96tLQZtVzA5hmGGlrgNYASfwcUHk/dcyF7WXXybnxXm3XZooIAfMjI6MsEYH0Qgkog30mpBIgg9QzRlJdCrgLopSAiKZPJ4ChswPom3E0eQcyOoL1W4R5oqwLuhdCor2THh+3L/Pyki2vc4DKd+qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199021)(8936002)(316002)(41300700001)(44832011)(54906003)(4744005)(38100700002)(26005)(6506007)(186003)(6666004)(66476007)(6512007)(5660300002)(478600001)(4326008)(66946007)(6486002)(8676002)(66556008)(6916009)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ygrodU0GmcpasPGmA5MJrkMkbhYbs+j8Lw5gCjbQVjPCkHI6y0IrylAjScy9?=
 =?us-ascii?Q?0LrAwK+PwZUtFb33Ky8ZW8Ef4XxCetLse5mhtdFM/8UmzbGj7Cr8aVi55Uhq?=
 =?us-ascii?Q?MwoB0EynSK1TGSBKK1Y+EfUd/NS+N0lzPR33AFqBIqiQo7FtKZzebvc2QOZL?=
 =?us-ascii?Q?/SJe5isH7jsV0LEnUYvkw6tThJYRm+nk38a1OqH0KizlL8J1dCH+SLfVQnHi?=
 =?us-ascii?Q?iyZ5GlfJCOULFNReIEY/eBurttZ9iiQJUWAPaOO7FPeypFvWRH9i4ccn7rG1?=
 =?us-ascii?Q?ErRjU7IbmH7/wlqcM94houpUmU4Xonr+OcEQzhzdPQEH56zekmDYvBA88hi0?=
 =?us-ascii?Q?vNPBUmX6U/5iOnyDhS1VsptoUmNRgNvdL8/vSxlYFmWPzyMg/4a0CmBwgqAv?=
 =?us-ascii?Q?6I/cnlSqd/DBH5cA7N9wpjI9F7FYIYfMFXlZz2P9T2rSiD2edi919NVwuHj1?=
 =?us-ascii?Q?j3KlUNvjpOGH8NnVVjUD2UvKW7asoco6mrFOsShKXLTBQP0zhuXEhZNHvot9?=
 =?us-ascii?Q?YkIPWn58hwGthJ94Ts6pKNbVNX/TtUOS4XA5iv8Imj1HEli6s/F1VBx539qP?=
 =?us-ascii?Q?FUdXjOAdZZ2rzRqmzv90BnGWpVZlDU3OhpUoW1SEbjUtGxBYiD8KlA+uJhIn?=
 =?us-ascii?Q?Ycz/oFsc5RSDG3/P4HIP8X6kr3uF8PhPhBOn0whikgE4Oebp92BsKJeJdXcg?=
 =?us-ascii?Q?s2p1k5+Sax+DV0Gw04utKZ/5yyDOQeg+RW+LzOcNaqtmrl1Uw4WvR414hfpU?=
 =?us-ascii?Q?k/9yUTsP3AQj7Pgutw7uW4hzPi4HHqOhiRJnXh6PuQNmQYWLm7N3Q26ZkWWL?=
 =?us-ascii?Q?HFKR1HG6FJh/718HcW3G79enHEn7FB4cLdDGYFc71gJ84yZHlnvgD7HGPk9f?=
 =?us-ascii?Q?O75Rv1HXHdaJ1+EqUZh0BDTxn4ltpYjDGsZRuGOlIHsBDDL6YSP0SLxDIdMw?=
 =?us-ascii?Q?aZyB6CDg2It/udyVXLrGl3R9hbza8RslawmK9nU0K/zDDjgcrj1rHdgD95rE?=
 =?us-ascii?Q?3OQAD+w0qX65vbWyhLg0djkSKRqHwmLAvYV77Qu6va8Sknm7CAc7XH51AUAs?=
 =?us-ascii?Q?nZeJbJqqOKdhTYZMEK7KmaDI78wy0iO2Y//30JWKdXOjr/5EtC2YwRD42dAd?=
 =?us-ascii?Q?nFc6p0MBH7zqv5ErL61X31NIEcmTgkaiAAS1DJ7+BjGimZXcf0SUUV99Bwb4?=
 =?us-ascii?Q?Ta/xCx9ozhXE5fwCRDYJeBQ4Fc1JeJg2/wFYl+TVjyDOdgn+kjtR4Ly76Eij?=
 =?us-ascii?Q?SwtIy+6fvo5r8VE76KIY9+HeJnQwTB0JpvY3Kt5n7bBh92CVFDbZQxCuZ5dv?=
 =?us-ascii?Q?MA4PhFgd8+f1+yqj6iZCtW3zhNK1ivCAA7y88jL/HEd8/MrQGnAI5Ua0xrUp?=
 =?us-ascii?Q?yRr/5L61jP8dy3FCt4lYvzbqZy4coW4+k1w26W80ejWuM4fH/7nIupwx+FVd?=
 =?us-ascii?Q?Z+cR3heGTORxQEdxTCx0cZa6Y6C0YHDam+YEjMBjYNea+vVtuCM79gOoNXkx?=
 =?us-ascii?Q?6xmjaXw4/aye9lYEjomDbiiNzGzWD7fpsju4Q84u8zrkg3JBl5GLtcqGFpBY?=
 =?us-ascii?Q?XokURPH6qoSaK3n2KFlD0yKUT3v6vfNIN20kf0As?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26956dfc-3293-44e6-228b-08db2ca892d3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 20:44:33.6245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uehqfmOyMnirA85Q3dO/Sk7erWVu2a5JsuhVXOvIoZ2D0WWhlKdsE/Wa8QvvbK3Y8diGcCPL6aj02AVQj/d13A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8304
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Mar 23, 2023 at 08:26:02PM +0000, Luck, Tony wrote:
> Yazen,
> 
> I folded the fixes for the issues you pointed to in patch 3/5 into the series and rebased to v6.3-rc3
> 
> Resulting tree pushed here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git     try-storm-on6-3
> 
> Builds, boots, and passes my storm tests here.
> 
> How is testing going on the AMD side of this series?
>

Thanks Tony. I'll try to test by the middle of next week. Sorry for the delay,
I just got back from work travel.

I think the code looks good though.

Thanks,
Yazen
