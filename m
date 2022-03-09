Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E1F4D3CB3
	for <lists+linux-edac@lfdr.de>; Wed,  9 Mar 2022 23:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbiCIWOJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Mar 2022 17:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiCIWOH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Mar 2022 17:14:07 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03114A3CB;
        Wed,  9 Mar 2022 14:13:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvUDE0wBAuglFAESHRMlCZGmJXsNB/rk8l+pjZBEK5suhKsR5XAvuZS8RuJFGJs0SbLBORTdiHgC2wl03LSleNc5E2fpx470nRGhJnQ6Pa+mKG9tcdFWSrFh9CTo7KherQNey3KfC6zR4YVA5muqW44YcKyR5iTpAGi4b9oQo8X8o06agcrg6v1lPUM60aGlRGR4ItuxUTrDRrTp2EDtvGK5rYyhS//Zh9Nm4wrbLm63kMhD3TOqOW59MjOVtBgrR4HXKWv69t5XsBIHbnUl+vKwjHC0MbRSWCMafIBy21tOrJ5WXEnoDmMqa33p3tKrkTxCGdwOUx44s+hEUAGceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEw3YHnJ/bPnGVthi+A0NrEF+lKjuLrLZJ1INHgcBFE=;
 b=OpxJ5NGIWG+S9Roza7Z9NWXgew6gG97lvc17TF7Ldqt+bV/hzZBy4ejS8GNs4uwSq+NTPrrZ/4PfWm9N9z4NHNaQsMfnd8RXubzdLQIOYw6rdgTJm0ABDqgTv9Yoa4o3I+RDJXaqLXQsaQcEHb6GSsy8iV2vteDdx1uByLfcfHXoxzZ3xUH93SBjUxGzdwpH7adUKiMMQOtgEF1X0fZxwZ37+UWAzoTFdVwIVyA/MC9+mzJ7wnysme36iuFx8XNVQmoVyj0YH5MxtN+fLdnj4Nml55OMlBB+OasCywyNIKmddmVattWuBYuaXcaFBy+u7BqIag44QXzsT7sKsi7wfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEw3YHnJ/bPnGVthi+A0NrEF+lKjuLrLZJ1INHgcBFE=;
 b=fzKbwh5G2Bo9qX8nhuHPZrQ82mqIFyiVF3U/PLFSGHAVujqNyYLEeedeWjjajZMh+VxauvKBDde2j79ajLwfAVquM9PO8g8sRXQjB/WejYJHz5xxjCh3SSOAXEtX2WYT1SrlbERy01PLTy7BAQ9ZwNErqWE2rjro6UrlHJsvhDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BY5PR12MB3748.namprd12.prod.outlook.com (2603:10b6:a03:1ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29; Wed, 9 Mar
 2022 22:13:05 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ad74:927:9e6:d2cd]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ad74:927:9e6:d2cd%2]) with mapi id 15.20.5038.029; Wed, 9 Mar 2022
 22:13:05 +0000
Date:   Wed, 9 Mar 2022 22:13:01 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v4 12/24] EDAC/amd64: Define function to get number of
 interleaved channels
Message-ID: <YikmbdnyNQx+Q/jJ@yaz-ubuntu>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
 <20220127204115.384161-13-yazen.ghannam@amd.com>
 <YgpJHNfS6cs1aEjE@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgpJHNfS6cs1aEjE@zn.tnic>
X-ClientProxiedBy: CH0PR04CA0096.namprd04.prod.outlook.com
 (2603:10b6:610:75::11) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ff0be49-4a05-4afb-7caa-08da0219fc0d
X-MS-TrafficTypeDiagnostic: BY5PR12MB3748:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3748CFA3D571A3FA5F828014F80A9@BY5PR12MB3748.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 39t4qakRf29UIGNNav6DcXW6PkHQnGxb/aYdDiagIkOtEycWck3XP+9lL77ix6XgqrZPV5GQdGvVIs89Z2pCK9hWTFC0TimHdMVO2l28fN2Ved8kBJ/OQrhojICOF0d8wbhOAkKEvoL79KJtOl4yT1Y8bpft4tS+KcIZbQJcUYg0S0lC67R40EH04OClJTxu2I9KCEAfDPFzGDsU4HcbJcPkAapNJ006Jjw4AgSsgIQyQ2Qf9rVegmwSLM1GzbsUfxqRQyyiFZh8vfteHjtVFGngTE6PZok3eMhiYOy036T6lXNDgFc9GhtypMRBzby26mdClNcBnAZcmaDjryLe4OX3SBmiGvQG9E4MoaQzPNJkkaJBl8tmHQPRHqaREcGr2v6TuONa703+imyshARTreZrU219mt+LqdEPCVAMFh/Ce87TlANHw6hUcNZniBzYwsoZHvmuPg2nC6/VpEl1WyGq9iSLxFv+456y4OVugzuChJIYLAnvNOC7m0SmuTjUXznMbsP+WMyDs+PyP2jYMdwyMjlz3sMtjjuhVZQEb+VnHszi5eXIANok8MQIVPf6dVmwqF9O/OUu6FNJRqF0dnxPFKrqQuJj36lA3sY47xVuqP9EW7a+NLq2FIj5xHOpUojZpOhxUVJKm37pQc7rPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(6486002)(6916009)(316002)(508600001)(8676002)(66476007)(66946007)(66556008)(33716001)(4326008)(83380400001)(6506007)(4744005)(38100700002)(5660300002)(186003)(26005)(6512007)(6666004)(9686003)(44832011)(86362001)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UqPzmdHvwr1E8D2LM8KnKpLsOxb/iQKZ+vrTX2G1Rq7g5n/JYSQJC3YGr8oA?=
 =?us-ascii?Q?22LY7apqecYn3XdPMcQWoReZcPsbKXv4EAKgY37BjANKlQgNu4Sx7EORZFf7?=
 =?us-ascii?Q?K08BI4V1v7jVyMc7H6g+ZHsURxwNaSdluxxmcrmLNdUPCzeyYjIKhzNXheNy?=
 =?us-ascii?Q?pGIiEqrbjvcu4uTG3lKQs1lQCM80QHAG2RzJkdq/UB9ls/da0B85r3iuchGe?=
 =?us-ascii?Q?y6k0eKq212kDJIdK2p8RNXcga4wvNLUVXYheaxN0GMzzTuuZUZ6uwOAJuah7?=
 =?us-ascii?Q?RK5ap/n356vDo5veHvHp+FSmPHDCaabaZtoH5LV8iORw8sZETmn1RBFmaaU0?=
 =?us-ascii?Q?SoQt+aQVFj93RRK5B8BMZO2o4RkHWczx2Iv4e//MKS1RZdmazTd4104Paut/?=
 =?us-ascii?Q?vAywvLY0q/JCoT4ESjZVFvwN/j6dzRMyp3eae5pSrP8x8rCf+pRjXeGQjy7E?=
 =?us-ascii?Q?Cb3/dp3kt3UThzHjcibjg0A13vw5cRPXMqJ8BXRmEcsItOsM27hKvp8efyXA?=
 =?us-ascii?Q?i+/Sy0bhr/A6leP9e6as/wFn+crTZWawFFaWnA5YzT0/iG3QKfDtholMswqw?=
 =?us-ascii?Q?xg6R5uKElfKU6gkclZNP3tMgj3QYFpbq/skpQRGtT8SQNN45KnkPJ5tfi3c7?=
 =?us-ascii?Q?4dF98lxIuw9qs/+23Rkxq8VMSioyaEXnW5iCCCQ0tM3FlcZajX03EtA7MF17?=
 =?us-ascii?Q?LUtjjrTwRVjUKugP+0m+4N5feZ3ukEP5vhkz9ZASvp88m9WVQr9C0K7MCrgb?=
 =?us-ascii?Q?0F0k9+ouGUvPewyscY6x+G+8VJr1XH+D/f7VW3ZiNY796FqhvhnIsAaBX/Gn?=
 =?us-ascii?Q?iH4g11+eY16evFmOUFw1fTbOkd3oz4aa/p3inkb/p7Pg/eEd871sTx4BV0Z3?=
 =?us-ascii?Q?ZihBnFU3sxWBsAWDGO9DgdKOObRSHAOwU9jLhE2Tkk2HJXy5Tt2vYRFol4A1?=
 =?us-ascii?Q?xd55QUwbtpAeG7Gs2fkUtMBK4L8+8NcFuVKxTbI2lixWExfTfoZve+m54egM?=
 =?us-ascii?Q?rK0ZC5RKD2cTXtxoSk8bnQ7cwZVeUxh2uRtWAU9SImerufr5d7F5z4QISTSG?=
 =?us-ascii?Q?aNCbhbQAl8UxCfd7rGOobDCpTDreI95+AQ/M4V+F38AbC7kiuadpFNz0w0Ge?=
 =?us-ascii?Q?1DVQWSWtrw35+UWnil/2zRntBOhDiRF9AVDx62qii4IQCui2Efd5RkhVaVBq?=
 =?us-ascii?Q?GR7vSUvE22j5BHbBmMKSOjKjlkE8ZaN7HfucbShVdIhk2RMvJnEptVnq8v6S?=
 =?us-ascii?Q?iR67RqGPfFj7FOsbsRgkGZMcAuCvkIdI1aVvAAnvjtuRygYWA00nTVMcB1qD?=
 =?us-ascii?Q?fQADKc+ERFrkOx87LYcfZWRSEYIUBnknDv/uElSSykOu9xQcok0y2cukTh/1?=
 =?us-ascii?Q?Rmvs9PFJGSAKQ/SVkCUE1jz1uH/sJqwBpC3OcZJaYoFajEqG/GWWiTQG3iT0?=
 =?us-ascii?Q?Nw6WwTpeym9H7jFRqf/T1dm5rtaJduyEc7wTsmnj6QmHfUduwWUjJztvO0oy?=
 =?us-ascii?Q?9BKqxb2121txVbzOzmr0MPsBBNQ+0HI+lGB2rtL1B7dD+q1zkpX8HZ+uXtvy?=
 =?us-ascii?Q?17riut+AlfwWBz5cD5SDJMLWF+XtOC+KfO7ea+KBYiAQd/jP/L0nQ3LZjiOj?=
 =?us-ascii?Q?ND8pzWyAr0QdUHrFgATYTYQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff0be49-4a05-4afb-7caa-08da0219fc0d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 22:13:05.3620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWSkvw6yFdRZmRjcmlPxhb666kSF5u6zmKCZpr1PYv6Mfqof4L9gHX0i+QwF+cFrDRJOgEzy0IxRriBfBFd/yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3748
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 14, 2022 at 01:20:44PM +0100, Borislav Petkov wrote:
> On Thu, Jan 27, 2022 at 08:41:03PM +0000, Yazen Ghannam wrote:
> > Move number of interleaved channel calculation to a separate helper
> > function. Drop unused cases.
> 
> ... or by looking at that change, I think you want to have each separate
> step in the address massaging be a separate function. Which, if so,
> makes sense but you have to say it...
>

Yep, will do.
 
> ...
> 
> > +static void get_intlv_num_chan(struct addr_ctx *ctx)
> > +{
> > +	/* Save the log2(# of channels). */
> > +	switch (ctx->intlv_mode) {
> > +	case NONE:
> > +		ctx->intlv_num_chan = 0;
> > +		break;
> > +	case NOHASH_2CH:
> > +	case DF2_HASH_2CH:
> > +		ctx->intlv_num_chan = 1;
> > +		break;
> > +	default:
> > +		/* Valid interleaving modes where checked earlier. */
> 
> "were"

Will fix.

Thanks,
Yazen
