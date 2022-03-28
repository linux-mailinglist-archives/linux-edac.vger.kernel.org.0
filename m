Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A044E9CF3
	for <lists+linux-edac@lfdr.de>; Mon, 28 Mar 2022 19:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240796AbiC1RCM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Mar 2022 13:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbiC1RCM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Mar 2022 13:02:12 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A1261A14
        for <linux-edac@vger.kernel.org>; Mon, 28 Mar 2022 10:00:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8aS+7swkLa7Y0BKC4SIbfwu6VGFDzcwrhmEurRaXZkdXUW8tIvhGz/T5J9Rl6b13PaaNZw6TJqKInh22wkO58InB4r2SJuXSyUoV+U48fA+HUWsubHoKDzIQky061i91eW3Y4iuy8ZBUOxuaAlP81pbXhgZkJ5SI/adQb4Vyx5MmuK7/u82Q4oapt6V1Ag7biHhlgWD10eeaZ0/NqKJofl5FinTyYGy2L7e9qnUKmxl8uqyW0hy1AQZV1+JaJJ9YgkGBZxIiEDYuHUOwpbreQKs499W1Sq90BXTCn/ySxz7VoCntaL7gFM8gxGY3TdgDvhgoaJjVGbnyKLUsQYqWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91T5HKzbaPvho16inCJXjwpGVSfj6hN1GfNNP4S1bFU=;
 b=My9qEwJidB6pqGjBLM5CxmDJUHkCnjHCRmalXGsckWiEvUU8bR7MKVVgtwbrrwIFJtd1W7Av9DFJwZOwUero7TJwH04z3bjwMTVl9fdPz5RB43gwWjsW9omfqe59LUcon0PoLrKADznMuDMG1eX1ZorlbsMGGuJieg8MFG53TW8IKNfME8KjgOv6OhQN6BPOIssyNdtUelYHLYAcAEOU9YvclZqdQ8Z+v0wZmhZz5ikHxirmvWHFHwRASXoNZvHvsgh/s8fATCgFl2Nm7lDkavKQ4MfipZMlnxfSFtePfyh3/JJ0ir72Sou5kB0ablZVogh4UMxJEcqUgVBL32Pp5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91T5HKzbaPvho16inCJXjwpGVSfj6hN1GfNNP4S1bFU=;
 b=EbMQS9hSboQtlHwSX4PDgjwoO+K+0mcOQdlerzYdjGzyVC0OgAqqbUjTLcwf1gzNql+dQqzPPmSVJ0K9oXSCL0JOC3zkck0S4gFzKT/PYFO+b0s6ymtEyQbK1i/ZFMimhWaTln7bM7LUxMd0kGOW0gfAV0zs6Ho2bNpIzaiVF8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 17:00:29 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0%5]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 17:00:29 +0000
Date:   Mon, 28 Mar 2022 17:00:25 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH 13/14] EDAC/amd64: Add get_cs_mode() into pvt->ops
Message-ID: <YkHpqQVfPzzcwEiR@yaz-ubuntu>
References: <20220228161354.54923-1-nchatrad@amd.com>
 <20220228161354.54923-14-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228161354.54923-14-nchatrad@amd.com>
X-ClientProxiedBy: BLAPR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:208:32e::14) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 051f6cc8-787b-4a69-a15a-08da10dc764e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4200:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4200A5375503476F02E3F63CF81D9@CH2PR12MB4200.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWPvYLGDjeCiHagNR9ZMhax107xbtWhytWemgkLV5mntIpdR4ghOC09zzUm0GDMifIvr17HijZrsUDws3X5E9X3GVtFjrd+bUyGitck7iuC5kBXxD5zxNLafVOsxwXM2bdWGFtbzwK5dzisTVGE85sECGMgqAm58cMOI7p6HrwFx8xdcYwShpnJlnyIxCbS6urPQ4JwIY9dCwAxgL9/jrmJ4TMwiXdWzoXhie/8Uo0XD4ReUJydPObkt/O7mIEsD4T8tnSQyM75C3eMVA2lTtVB13xHk8fYdd2sPrm3k90eFOYJvPGcZnUaI6kOC3i/Yd15DvwCnVvzLYP7u9LG6H9+QRIzGeNcITJ/May7Ow1k7xbZu3vboCKewVqHq0xmoXNJIH7PFVKg+UsOUhiUMJ5MN2O1xmUwMK7pO2lkCzqIAbpZCb4l8c2WEM01HcuGjTq6u96lGRhVBAeBjU226jMpDBjzg7OUs51XYpTJpQxOW423VstSKbIvDvu7CJqHp+T3shVIzW9x6XAUXNOHsqxmqD6d3GJCAzpNTg+xvcvubFGSVZwU9iZeS/kTSNutG0Iud+qZb469XlRlt6VVpA0OzV4d3b7Saqvnubq0e2RiMGZSdguHwd/6LflMPkNI+LBZaT8CNPDfLEnd9pTle7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(6862004)(4744005)(8676002)(6666004)(44832011)(8936002)(9686003)(6506007)(6512007)(66476007)(66556008)(66946007)(33716001)(4326008)(38100700002)(5660300002)(316002)(6486002)(86362001)(508600001)(6636002)(186003)(26005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?06oAJySmyGf8pmRoyr6JxTAnHZwT2bNalX5ug8OeWjTAjSlnjg5pFxonXIS7?=
 =?us-ascii?Q?5JXuyIStTKGVppyTVhijPWUMJErmIspVnt6uaWLtoJHmXj8gFWSoFPzafUqB?=
 =?us-ascii?Q?RBzb3oJUXEePGKOu9g7Z4ML35/apbsx0jQIV/BjhC91+Jy0aLFI4E0jnLkLi?=
 =?us-ascii?Q?0DlLqfA0JfFA34nb5yY0EO9XhHwjr+kvQw7JnOU07dpj0ptlSWGga3vOW7GB?=
 =?us-ascii?Q?oXG9mMvCChbFNAKUWtYm9F1yiYVwG3nq4P0A8Wzin4bVjjDzC0k0G+sIPPf+?=
 =?us-ascii?Q?BPCPGWt/ieXCioT5S0FNhyxhiaBmcNVlnKQPyLV4zMAoFn/0VhqaGiEFrtF6?=
 =?us-ascii?Q?/Yy0lQc1rjvnSI817C/IPmKy1UvNci+xI5DcxXIczVCSafwRiSq1qzlOWH9w?=
 =?us-ascii?Q?V1z3CKAapLyzaKNmG7Psz1CmamT0ejxQuiQprwTif7b80VGorsn4412mOG8h?=
 =?us-ascii?Q?ddbLPMS0he7r5OeUc9LWuijTfHuvkZN1zD9Cd6fFC4Ih5yfB1VoB6mQPsl3d?=
 =?us-ascii?Q?9ZTksOCcA7pEQsmmQ1uuLmO9rSvJ2JG9fcEeeygvuz08bUECNOcvgQqmdHK3?=
 =?us-ascii?Q?OGi/mbUmceCviE4IqwA6jG/3rfWTFQUMTbssRxhJt2l+2fK29ccI7EPFLl3F?=
 =?us-ascii?Q?OvPGcxpQwvzWGVai+nkG/TNL6QXMOXbsepWWiCwSEfjJBa2l5+w6J+Kc0obP?=
 =?us-ascii?Q?u6q7+SSGUtPNv6Dpw4ar4/JIMccZpDs6+O0CXot6zHDfNcUWE8e8KjEWlVL3?=
 =?us-ascii?Q?n95MClWLjyt3UhBF5extRN4glofg+Ws6bf11TpW4JcVhBn3Z1fFbcTI57X6L?=
 =?us-ascii?Q?JQuqXPDfV7BJ25ERdDt04EL77lkehQSCdB97e8PEO9Zp9k+6fGxUMyNb/qPI?=
 =?us-ascii?Q?94flXpxYqRlYPQ0M/THRGec/ejbKwCvC2AsTzwPOwz5F678N2olJrpzHmuFd?=
 =?us-ascii?Q?F/vic+n3MzMOL5HjkBaxs7I4boGjbikQupsdqoQj1F0O6I4zV10Ux0TlnydC?=
 =?us-ascii?Q?/2n/ZGbBhdXCcNXqoo3kt4zlbbC5HgLEUcO19uyDiTzCANSXN9K4WCFdzYCA?=
 =?us-ascii?Q?a2H+8DsZHsvOYaVGC2NHe0Kjy5MIpmSBKmJbG8uDaUlX/NNJRIOJAjmxBXTG?=
 =?us-ascii?Q?ke3SA3p7nio2vQvte+OoeMDDxwB24iO6ghlSZ6rnk0P7OhJfjdDfLzIFbeTx?=
 =?us-ascii?Q?KXit6LIueOR4SPiQKUGIsVLhNKQg2LzS1S+HcuyOEQQlVobfBgW2/RJMEfhv?=
 =?us-ascii?Q?MBDtAk4skT/v08Xubcig38cNa/0gnbg7OWiNbBXa73QTiIieOkwGQKegZ9IT?=
 =?us-ascii?Q?KrK08LCZKO/EMNm5b7ZlzdPxIBmuCJG2NAeZ0hizMad7Lxyu3uhpJ/Nkviol?=
 =?us-ascii?Q?ZKH/GQOssmv4sD86ReAZWgNkPhOUcZrS1r8gcA4Sry570LbR5lXYIJGx8SCC?=
 =?us-ascii?Q?hDmfRVju/6sMMVfYFPilkWtjlJBDaF42lhEpqve+3myh+/t1yH2SLVYE3u2g?=
 =?us-ascii?Q?o+aS2+rCR7m4Bmzw512cBbRMEWxTO6U78lAsdf6ZhA3q3tswNEqQuNrmi+GW?=
 =?us-ascii?Q?ZlUoJKOHFf38r6MT03lb/vkAMsiA8ZAPLRkXaz0Lm0Crn9EdTETL/xjXnzcm?=
 =?us-ascii?Q?TLu1FinbOnFy8eSUv5csIebs8oV8IV2dJuIv9vsZcWBvhmqC5e05XlHy7NLz?=
 =?us-ascii?Q?I+nqM5hNe9k7qDRzbHTZUMksDbCqIaEzWAUbPnrA7NkLz1w+nqaxurCtC6k7?=
 =?us-ascii?Q?zXkrE9geuA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051f6cc8-787b-4a69-a15a-08da10dc764e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 17:00:29.1779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3beTW4odhYmQH0nknUBJIZuKdws2u4IILWzYKR0FSKhpLWUjQTtu0etUYftgudjJebHC3aUdM/bOkbsf6oE/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 28, 2022 at 09:43:53PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> Add function pointer for get_cs_mode() in pvt->ops and assign
> family specific get_cs_mode() definitions appropriately.
>

Please include the "why", but otherwise this seems okay.

Thanks,
Yazen
