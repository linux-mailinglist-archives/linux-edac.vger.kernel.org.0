Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03A04D3C41
	for <lists+linux-edac@lfdr.de>; Wed,  9 Mar 2022 22:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbiCIVnh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Mar 2022 16:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbiCIVng (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Mar 2022 16:43:36 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2065.outbound.protection.outlook.com [40.107.101.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C0AB2C;
        Wed,  9 Mar 2022 13:42:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fO2cyENPZl9ECa5b1DzwEXS83Xzg3VtQd5EVEX6LdqdhpZ+TX0GOCzKKs1+deCyFdhDXfzCQL37bx2hTZhCwlplvZvNGS+u1ZVvWfuFUAFNNrZWOS2OUnSwCUixe5z9tf8viGVsgQhzg0eU6DRpF7GZOo2nsz+mNSeUp+Ry/xID6lYFU2N9cGfhW1iahXAPs8SYoevTIRMAyTUM5ChltkyTNzMxbfsQcVN6Rye1iCWchfYutFFXYh/dDkngvg0d3NspySHgi66MtW5pO+bUaIVO+Qemjc8S5MR7dhFYR2JolpbQn5gwsIv0YLMtuVDgDB950YbWDT+i7wVUj5CdroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyvmQgsTAyYjySt2k2yDsFvIzbISIYRFc0usGftmSF0=;
 b=eZG99cV7Z3+DlLHpTWv/JuafghOZru3GH38ufS9BSaxb/C872S4OhDhyLkiMwrK1toYePAW1e5SCBivrLU7ocDc6LIgCDZ49Y4gcFoof2zv2ym8Z4hB6rLOWglF7qyYv9CxCRDkNcgvfm88GGwAuxGfZHcSpZ5C9Dd9y9EQRVqhPqUAJpj6C2BvK+GWgTpph104Z1lL9qhPuWHF5uMvdhqynF4Dj/cRB7HD6wtZi/AxnGZQaBsLJ0efD9iPVfm0fi93PXfG6IK12rrgZKAub11A0R0JZH1EN+KI4gMozSEI5qBPPfRJihCHkmO7y3D90ubMiAAN1QIHNwsgwbfbuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyvmQgsTAyYjySt2k2yDsFvIzbISIYRFc0usGftmSF0=;
 b=1ZY1BuKl6F+0K1GgfkVmZ3XLXwmP0t+nFm7Q2gUdGRXJJoTpHBoPnkoNWwMF6GZyFNhfTZ8bcMZtMNRERz6qxb1PNVkkQtAWlWlsVJeiRZZZohi5syfNg9Ts31anNSG8Tla6Hqewp0UMZfakeq6yHmYxRuk3phU764vLy1PqVq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB0241.namprd12.prod.outlook.com (2603:10b6:405:58::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Wed, 9 Mar
 2022 21:42:30 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ad74:927:9e6:d2cd]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ad74:927:9e6:d2cd%2]) with mapi id 15.20.5038.029; Wed, 9 Mar 2022
 21:42:30 +0000
Date:   Wed, 9 Mar 2022 21:42:21 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v4 01/24] EDAC/amd64: Define Data Fabric operations
Message-ID: <YikfPWACGyWPIxKP@yaz-ubuntu>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
 <20220127204115.384161-2-yazen.ghannam@amd.com>
 <Yga0s+9cqtfB3Yxu@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yga0s+9cqtfB3Yxu@zn.tnic>
X-ClientProxiedBy: CH2PR14CA0050.namprd14.prod.outlook.com
 (2603:10b6:610:56::30) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1625643-b72d-4751-d15c-08da0215b640
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0241:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB024139DDA7738AB23C483A07F80A9@BN6PR1201MB0241.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZkXnzc52P1lOem4/LTuGOeL2EgYHLe7fpgsK8Qf5NKg8h3jiaOyrGeF3Wq4iE9Twk2gQVQOVsAifZC+4E9fuf/cnI4I4LxTPxxhLBnUSOfVWN1gEogyEzusIIQpEON2SwB0zqveAC4kiMBI8u6VcL6fsTgO9e4+S/7eLW2Sx1Cf0rDqd7hPhV9NQZGAtJhhebBIKkithxA69grYbSBgbeedUyH1/CzGBhmpSrZuTypY3MNJsDXjRw4wdT2d2kiEj2j3EHXO8vpSWSHzAAqG4XKaYwWvxCeqAXJiYvKPxy0zD6wZt6xn36LjsbtzN5Z/RsyTBglCNCjPiXcZhGf3Q9iQA34P3MDnQa1mPwojfyREFS5qP2hiQGEwt5QIqMPO5dcfOaOfFpsQSvP8i0quK4Cz45dLQA7Tgkpd3OogTtCTNDVe2JENOnwwkXz0f2PZ6L91sK1eXeUe76c8unX22lOr4965awm3bL9kSCCy+MyIqOIpYIYf8e4z6eev39aBwYejVxbOZKn4VN+PeraIz5hIl+3VN6xOBdQMyJ2fGOLHhIw9JTxLSdFYxZOIGZ8wIxUS4XLt2DPT7bFh/Sifv83WT5IvcnatrVDMjEiix37cClJaVDqi7OFEsLdVDgnmPoEC3ivZsbu/SOdy9VrqO/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(5660300002)(83380400001)(8936002)(26005)(44832011)(508600001)(186003)(4326008)(33716001)(66946007)(66556008)(66476007)(9686003)(6506007)(6512007)(86362001)(6666004)(8676002)(2906002)(6486002)(38100700002)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zmLFaTSzId11VBot2J3W9OQw9glFlI+JMHwv3/64G/my/0a+TSoGwG2TN28Z?=
 =?us-ascii?Q?XKKU+vnLYWTXk9TKiDIUc+OMwXk5UOLjsvhpUZjsa2iZZU4AmNtDnfzqVHq3?=
 =?us-ascii?Q?owahu4yOwNLHO2lZy+/Ii7rviO3PKvFP1w2xhHpNZ+LDCD017/HgOfYjYiW2?=
 =?us-ascii?Q?hVqDsmyP1fcOnoO8mrLwOB8vXCVpjC4bCG8wIJhOEVZKDqKU4XlJspfvZtN1?=
 =?us-ascii?Q?TuwOHsx37W/y3W9Wp0Gxf+YGZPx6O1JiQcOEHmjUYCcXw8+nnOKfg06iF2qP?=
 =?us-ascii?Q?UHqx79uIMjLzayvrrXRqO9POFU7EVMxeM2KETg60WqvR5yPd0L2vl56kcHXn?=
 =?us-ascii?Q?z+faK2gIgJxmaaZmN/7aEZr5aNtbHbPKHQ1pC2vNzqkd6+ooiUkhwIIfEcm5?=
 =?us-ascii?Q?11osdy6WnnfW8/jfvRYRDa3WUwU1jtMIpNtsnPuyVtdibr4vNMVMainIQrIu?=
 =?us-ascii?Q?k+IEeGtPFXEJfaL+5D8CtmKjGvSuH88v9lzuRaD4GLeQsUhNhUrZtv5WFBLM?=
 =?us-ascii?Q?seQVNVY+K1odhStfPO/WbRJ3jQ/J6rJSHIaTuInlsam7NHdWMeT6Gvu1QhAv?=
 =?us-ascii?Q?QenNAehWhXGQslG44M8y0fXjC0CqNlPrKnDyE6r1olam+iCnpWKmsvQabNRb?=
 =?us-ascii?Q?Wf/SEA0KmbffI5SzuW4BeuwGwdTap18zV+PWU05FXstGFI8QIvs6ad9F5/mT?=
 =?us-ascii?Q?XeXssL4eSdS9awFAzOFrQR29KhHAwcfIDYhYOOCFRQ+04lGUyVDS3sqNGqa9?=
 =?us-ascii?Q?7UDdEsVwW02ou9TlnCMs4J8B3rhIE1YUudtYoX1WLj7P2QFwAQ4oTHN0o2kJ?=
 =?us-ascii?Q?c2HW2OPaFuQehk8qvL2M4NEKD++wOJe9VsGr994VaSXCrogLSlQU+t4fhAeD?=
 =?us-ascii?Q?HFZsDAMdo6BZJEvAzzBVWw2HuYOjO/aWu1INuTCyOC/bWZ8MuCM4nSaaujED?=
 =?us-ascii?Q?FY5JxQbk1gVBNB997bqTK2g96WVl9a91/DA28MdZk2qJnRtPrTXEi3cIhlsL?=
 =?us-ascii?Q?mNqhQOTxf5R7hpWenjKQpi+jSzUFRpV6swNNu6sF0W4ZYMDwMad0XBe5U8aL?=
 =?us-ascii?Q?wjkZg34jY8LjzgLeqrAOAKWY/XhtrATLkvRb8Te95RkS1O/GDVt159YKKAa/?=
 =?us-ascii?Q?GBDGZbAKCJ9ou0vHMKUXuBoOp+GTD0AYzM4gNlvGGEIBfmWx+ACCSL2FWhJf?=
 =?us-ascii?Q?eizVQCnz5TB9i0lRDO5CHablh6wcIzjK9oYN3iPMvnV6JBrFZw+FjLE3Tncw?=
 =?us-ascii?Q?BTA9+dlnau0c+DHzzaY8LZllR5XuEF/XzfppmNXdiorN5dhSMK5FF4RtJ2Fw?=
 =?us-ascii?Q?xUwMqlaRkfxpG+vDrf2J8JdqWuDVwFpa89/WR5zKv6h8PLV8UyfrYBXHTZGy?=
 =?us-ascii?Q?E9iaos+zNO1YLFcWFteFqyVGjic941tVThOZuiEUTj+3gZE0p/1joYkN6/Gt?=
 =?us-ascii?Q?2YUmjZGUc7aR2DEjK4bzTw8NY5E73t11?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1625643-b72d-4751-d15c-08da0215b640
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 21:42:30.3022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQGI5AR1BrVUILRI9hv7HYdugZjxDJ1+VxiK4BIe1Y85/Iz9PQQofsr+y0D6Z+NOFLNWfyiuIiiTOp7aSUd8OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0241
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Feb 11, 2022 at 08:10:43PM +0100, Borislav Petkov wrote:
> > +/*
> > + * Glossary of acronyms used in address translation for Zen-based systems
> > + *
> > + * DF          =       Data Fabric
> 
> Yeah, "DF: Data Fabric" is probably easier to parse, without that weird
> spacing and equals sign.
> 

Okay, will change.

> > + */
> > +
> >  /* Protect the PCI config register pairs used for DF indirect access. */
> >  static DEFINE_MUTEX(df_indirect_mutex);
> >  
> > @@ -1058,6 +1064,14 @@ struct addr_ctx {
> >  	u8 inst_id;
> >  };
> >  
> > +struct data_fabric_ops {
> > +};
> 
> I know that this is not the only example but we have struct definitions
> interspersed with functions in the .c file while former should be all in
> the header. It is a lot cleaner to have definitions and inline functions
> in the header and the actual functionality in the C file but I leave it
> up to you to decide what you prefer.
>

Makes sense. I'll make the change.
 
> > +
> > +struct data_fabric_ops df2_ops = {
> > +};
> > +
> > +struct data_fabric_ops *df_ops;
> > +
> >  static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
> >  {
> >  	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
> > @@ -1072,6 +1086,11 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
> >  
> >  	struct addr_ctx ctx;
> >  
> > +	if (!df_ops) {
> > +		pr_debug("Data Fabric Operations not set");
> 
> That probably wants to be a WARN_ON_ONCE() so that it is loud and
> prominent when it happens...
>

I'd like to keep this a debug message because address translation updates will
almost certainly lag general EDAC enablement. For example, Family 19h Model
10h is enabled now, but df_ops won't be set. The translation code will return
early here, and the EDAC message will say that the tranlsation failed. But
this isn't a bug that needs a WARNing. Rather it's just that the feature isn't
enabled yet for new systems.

Thanks,
Yazen 
