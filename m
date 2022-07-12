Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521A5571BB7
	for <lists+linux-edac@lfdr.de>; Tue, 12 Jul 2022 15:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbiGLNve (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Jul 2022 09:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiGLNvc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 12 Jul 2022 09:51:32 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11390B79E6;
        Tue, 12 Jul 2022 06:51:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQSK6NAd2YQhhjYwwlnr3OJpOqDFXD/k+3bPg90+3dJ4CbPnsOtTGAhzES5nLqurkqO3i9kQIcyuu4X72Gjca2auOjONV6rz9p060bBDkKc+l4FIDbAK1x7a/ayfReL+ZskdkDWKRaIrA6BrPGN7DgBZHLuLyjZZaBuzkjVllZpFXRn4cGAjdo3Uk0KTEH8ZRPtV9g1weSCOoakRLekUIXhm5YQipKqVhWKy+QiVbuCgHN+MgQKiqiFBp7Rmw5fKhIMrwAGRZKJXdxoa/df1MdFKqBHIHyXpTceCWo8q3ZX2zWkR6RUFzZjebyRmWgiew6ngYNpdmqdP+ybmbJfaDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMLcnsPwGUyMGsw0Kg47NBc3E1L+3nP9DXNzyLSEgEA=;
 b=j4SAbjXkaKEXBrvmnLQrnSz5t2TS2MqEXhLqPdsxa9eWdFXezQ7lTdf/zE7LlFWbbV4pasoj/g5J3/Wlq5h6xXoiExPKBWpq8Wllo8kNNH7Ch1KsYCf+iXjEZOywVIZ2BjyK5StzQJ7/WgGJwBNdttx9R92OJEM+9Mn1b5Q7E5WIhP4ueB0yN20Nx1I7D/h+iwJC7K5nIfusYsWDDBFhIVgCWMTpObGWahWoNRWwNzXqIXrMwTrcw3KJU1REOO4TKCUdKURbeZHJfqGtaeGkS75DWD0XbEsV7e2P5pIG51kYDz9Cdhzu1wxHEcy0xAbT94AnwMJvuzN9BClRF4vB+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMLcnsPwGUyMGsw0Kg47NBc3E1L+3nP9DXNzyLSEgEA=;
 b=NFSzRu7OxTywrfqoy2JpXsSPxaNWU1ZX3r5NU8EyFWsLtYGk2XMR5lbBupaWHukePOoyrqJlUIZziNUS8C5xnNH/rqAkeibLZ6cZGf51ERSvAFIm69tzs5TXdbY+CEhBpLTab3mp0ydQzwqWanmXzEKW9sPlMbxKnWptxntUY78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Tue, 12 Jul
 2022 13:51:28 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c9f3:8fbe:281a:454e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c9f3:8fbe:281a:454e%3]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 13:51:28 +0000
Date:   Tue, 12 Jul 2022 13:51:25 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v5 2/2] x86/mce: Add support for Extended Physical
 Address MCA changes
Message-ID: <Ys18XVCB7CeR/jVw@yaz-fattaah>
References: <YlbZ1k1cT1FVJj4W@yaz-ubuntu>
 <YlbkCK9LU2KdXZUG@zn.tnic>
 <YlbzbZO6AvxOqQb/@agluck-desk3.sc.intel.com>
 <Ylb3/4oi6KAjdsJW@zn.tnic>
 <YlcnN2q9ducdvsUZ@yaz-ubuntu>
 <YlflJfyQR/j/eRkn@zn.tnic>
 <YlmHtlKABn9W0pu5@yaz-ubuntu>
 <YlmfZU2Bg5cRk07J@agluck-desk3.sc.intel.com>
 <YqJHwXkg3Ny9fI3s@yaz-fattaah>
 <YrnTMmwl5TrHwT9J@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrnTMmwl5TrHwT9J@zn.tnic>
X-ClientProxiedBy: BLAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:208:32b::13) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84d503ec-58be-41da-7214-08da640d9e64
X-MS-TrafficTypeDiagnostic: SN7PR12MB6816:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oXHUwYWaedovkjzVcXV78d1T65aZeQ4UK/tKsMR70B0zwnXlFKBs6GWn+lt4JpOumjQLtjJ873g0LbzCjttuiEWl+E0BUHH+b/135CNLZq27MnNxAPV771uHsGG4Xw0uFYwnjKROmC9N0Jux8qOgrMLl8b1SWdF2yn9awyYFu+05NzFtLejT2F4WrEMzn97U4dLnRjfVFBodgwOWQNX+4IvgaC8YfgmupIKIAagDbM8Rzl4jBYex5IVQC+f5SMJOH5qVf6aacdXZLukNeQ8wXLKCauc2GnKO6U2oFtf9eUqRES39GITXEEJGkoGtvxfkh4GyQrRltXTr3ed+9Dx69fvOmTS0lLEsObvrwDAPnwpy6ydupiYz6gd81fWyJXLPXoy5LoRO6VxjLudIbMhWjDXgWaEZpXEKhun3IBfSai1guwcWAkTvKwx+LbQxdV88oYZaZLTu40T363nInj/qniBtD/X/deqOiQ/+OzGki5Rfp4n7chHTr6iGqw5y7avgO3uMTBaK/kS/OOkTgOzKTV4STg+l0uTI0LbLBsaM0auo8aKa6F83bV3nzKuNMZWIXbv7YuVcvD8T4viOkJsTGOPVXP0NLb95Susw6xO60WwYfwWwD0r1kwD5o4UFyzBcw59YSfdcb7TN6Dn+uUG1F6OsHYXosWB0dV1iB5yBTchBZNIliaCAdzrOr7Xi0Ae/MhXCBJupewoCigGAmfVEz5E0MqQHO+wSpHzweyOlEPyGtLs4UG+XxxDFoFfCJ917
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(5660300002)(26005)(86362001)(316002)(9686003)(6512007)(66556008)(2906002)(33716001)(4326008)(66946007)(66476007)(44832011)(478600001)(8676002)(186003)(6506007)(4744005)(38100700002)(41300700001)(8936002)(6916009)(6666004)(54906003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GD324TnqJzPhxA4CYGdQlr/wNRGqjcy7bd5abFYTnK8yiO/VcpO1sugbtzsm?=
 =?us-ascii?Q?7Jl89uzerw2eSc0XHeScc06hO6YpkW/1/r0jjGfq32mxmRfETEsnEGivatLf?=
 =?us-ascii?Q?a4sIQpKN3T+EO9IUgu4IOCmtLFyc7nNo2fPrMdpgt4bHboKqL20s38FiJAfc?=
 =?us-ascii?Q?gtmYal//XL29HMbYh45jF/xEPBrJOGeKgmYsEQl2HB2g5vRpNc4bOPBfJ/vF?=
 =?us-ascii?Q?EKCizW4wLf9VSnTDA+4F/67kV8OmCgjKotwt2xZZkETZHvEtxG4o0EB/zap7?=
 =?us-ascii?Q?+HjOfttxoq63AycC3HHp2xL/yHR551+U+j5Y2gM9YrF4LfBU3qwF+vILOnM4?=
 =?us-ascii?Q?webkFa2fai658oVUKo5VYkQrOZyerB2P1MX/VVXOjqM/ehW37DEEbXud8qJY?=
 =?us-ascii?Q?DJGvYacZc4ZpskwdcK27RDf+ZnnNFt5BIMjsUgjgUXtzqkszHKzVuyVwDf2a?=
 =?us-ascii?Q?1NXl72w3YAJ3ynNNre8+cUTGQ5BNkr60KFc302S6FwuX6ZfcHTaZGEanyVI4?=
 =?us-ascii?Q?MkgHvMA6JHE8Rzqgjwhc7eHrWGNvMwlBESqoEAP5ObqoDGAwiZfMATiGW2Yx?=
 =?us-ascii?Q?YjPocUoHUontzmG8yFYajiJVo1uash7f1cMAxrjGrwjAmRK+z1ZapBYYGts/?=
 =?us-ascii?Q?4X+AnEbq0w3tU8iEVFEs0rTXFOsplM9b2i164d+gt3bzVHSg2gj3P6Pm/4hi?=
 =?us-ascii?Q?d6jIINLeXjEdm5NEAUkK+mCnJ5Kjavh7W87f1pTxwY5pMSRFjQJimN1xr+lW?=
 =?us-ascii?Q?u/q6Sk8c9idJJTF7nSUDRk0bFZ1iK9+OSuWFnPz5LTnaQzp7g2wGB5y50XoE?=
 =?us-ascii?Q?YZUc+qeStpuJAQ6N7YftOgpTcY+qeFkOX4PzjyNk1p/tDWWdsStpILZQvuz5?=
 =?us-ascii?Q?cWBqj/oiyEa2SdHuh7WKc1yu642o36lJGz2SzSDbAmLqhn2J1bd1AKnx5TnM?=
 =?us-ascii?Q?gcQt/fN/04E5WeFn1Owe9yVh5O5punEeaJLZmj8YOFIDCj/0sVSSbudLmKk+?=
 =?us-ascii?Q?nuVEJr0V4bESKVqOiaWYnc4hVOYZMyrao7rc+kH5bUstWaPjU93nevTHkNsu?=
 =?us-ascii?Q?DT6A2/BtqTA9hOLlDFIyEc4dHxX58fy+vbcqlBfW3Non4kkv7X51hzqk62QG?=
 =?us-ascii?Q?KofuNf53cGnAybSVBSLQ09H2Q/Akiwm88QxbPVz101ofVykVBMEVNcrO+zSk?=
 =?us-ascii?Q?QQ3iPIjJjLKHdOMLsWOYtXuLb9Khf2C2IC4NWtqlp7M3MWNEZWq6v/I3HlyC?=
 =?us-ascii?Q?Jr2+Pk562KuTFZP6xgyxkRPtaUt3hHt8QogBljRwumsxeP0bBHNa5h26ayCM?=
 =?us-ascii?Q?u9lqtTL+Q8sRTqEHCwFt9gNKkyGdJC2P//zHf/ANRq7DXQcW707GJW/zIZ3q?=
 =?us-ascii?Q?2k9HUpdlAryraft84Sb64OW5rm7iA1iws94GMdf5L4fszvYlrVKUBxVj7q2z?=
 =?us-ascii?Q?7fXD8kPhExs02TTbXwB1Yh1xK30AU1m+B7Jx93gYaAbjDKKfXFd89/0zbv2t?=
 =?us-ascii?Q?TCHuoEx8EKhGgfmVnfeF06aq2JzlIh/czP2yuruQ9gEzhstNCE63QdSre91J?=
 =?us-ascii?Q?I3wGhj+xXk7+qQK8sVU9JtJVRtqMz733K1Rg7KqW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d503ec-58be-41da-7214-08da640d9e64
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 13:51:28.3894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDYbVXxvWT70kButAt4gyd0+i0jXfyr4Gsiq/zC/+AO+g+LOwIWhAs84rwOz3Sya4VVJNEn7c4bM9pGv9RH7Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 27, 2022 at 05:56:34PM +0200, Borislav Petkov wrote:
> On Thu, Jun 09, 2022 at 07:19:29PM +0000, Yazen Ghannam wrote:
> > Also, please see the patch below which is based on Boris' patch from earlier
> > in this thread.
> 
> Looks good to me. You can send me one against latest tip:ras/core
> whenever you can.
>

Thanks. Do you want a set with yours, mine, and Smita's patches all together?

-Yazen
