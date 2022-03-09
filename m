Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285104D3CF2
	for <lists+linux-edac@lfdr.de>; Wed,  9 Mar 2022 23:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiCIWcj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Mar 2022 17:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiCIWci (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Mar 2022 17:32:38 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0B8120F75;
        Wed,  9 Mar 2022 14:31:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8IXmDgg6lguxV5FqfCQjedJFU2mnxp9JAruQnzTWUohFZuvBkZkhpDbnqANvulwXngLn69Lnzhyhk/OJpX9fJmnk5y0FIjBKWLpL69mla2u3KZFxz0MijLG++A5hODlu47itaVOaiNRLYqLxU9uxKu5x/WdZUneMz30LY8MWrvhAtbXyqWel1jWV0zvHKRMNRD/Y/gxL1W0oCQ6v7BhT9skwky8a4KBMaFRATnH97HDKCbJf+DCSR23MpmrwdTcUttuqwBxYLKBcbFZRFH32sUV5ZcmN/po0v/SAAH5U5mFD/bLw7aUNmHlOdI6PvTXOpYCsxOVW/7w/6dnSYcfYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vJsdUtt9/MjsgNxNVd11joHhj67iqGi2bcDPf0F9s0=;
 b=LTE3gQU8Vn2x7zV/vB6xAVMHnEWLr/c7uytMQ4Y8417wYibnAPX3CBZFnGB00xTQi+axoXS0niRdDoQdydgaAY1L36viMxV/JTYqaBH1sNXKs+JL5JaUsv6iEjNlhbGJu4GvDrnHua5YI5DSO3ANqRsDs1P8nvMp+m1pCDbXNgNOKygKBQiydzK+TgT7Va2PJpRd+wVq8Wjlaei2JZeucUWD8w1SFFoKx9oI4hQoTTWx64htSb5RyndIn+LdCkMDZtOIrkAkyYJbDov/QATFY0qlzex2LBlre1Ju1+L827DEsLvvXLLeZfux0Z/5eHp4v+sYXXLoMoVoI7cWZ4fIbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vJsdUtt9/MjsgNxNVd11joHhj67iqGi2bcDPf0F9s0=;
 b=pvfXeU770cw4gCslvuS0VKbv3bIiKzWBBhbga4YIINLfG2TPgteazxLRGBvTMmIIVHrAOVJIOZnPxRb11BH/r56iTJaCZhernfTlWPJ4bi3Gav0H/PqNl4Ddubj5IKXRim3JDE6bnQEFq/otnMttr4X4hg0/+lEWoToSkbdgohc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CH0PR12MB5137.namprd12.prod.outlook.com (2603:10b6:610:bc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Wed, 9 Mar
 2022 22:31:36 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ad74:927:9e6:d2cd]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ad74:927:9e6:d2cd%2]) with mapi id 15.20.5038.029; Wed, 9 Mar 2022
 22:31:36 +0000
Date:   Wed, 9 Mar 2022 22:31:32 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v4 18/24] EDAC/amd64: Define function to insert CS ID
 into address
Message-ID: <YikqxFfS9qrLLXM4@yaz-ubuntu>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
 <20220127204115.384161-19-yazen.ghannam@amd.com>
 <YgpUc7J2/4+n2oMv@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgpUc7J2/4+n2oMv@zn.tnic>
X-ClientProxiedBy: CH2PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:610:4c::37) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b0a7bd8-9412-464a-ea27-08da021c927c
X-MS-TrafficTypeDiagnostic: CH0PR12MB5137:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5137E04AD91D2783CD701CAFF80A9@CH0PR12MB5137.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8grsvPhk96wRpWDvBxy/g0wyLx1Bvv+yoiMODWWiVl4+5DqZYbU56DF3kJn3hOG4VPU30SUi0mqfd9ExrGymJ/GrVmgii0CkDSls1MWdArdCMdUL5vcKoHpdqM+xAw/xmePeml+bJTkVlnjH2f/7Z2m9u1vBIWgoZF8aaqMPCTToInMYC8Ry7mOJt1kaKHgbKSSw7bpaeajnJIqrW/wvhCojNlZBcXNFqyW+59oFxucl5ah7BCcPYLhma6hEWXPtAP/rg/2tp1zPSP/p1NpFks9WzUIHk7R84lrv6QjDoYe+qxBGwLZUUM2DtUUA+yLdVaNUcy8HhPAg1AFDDsOK9Dv5aqIEyMWE5x7fXCJXOjL/WzoqugTYzcuhXBEw6Q+5ZYlGa0EUfnxjC/99WAJK9MfhY5WqQWVpyXL9yyH90tvWm436heuoxROckjb2Yyu7h5eSHcZi7mtjOE9p9oDw/uCfCjv5OQzUj1XEOaseKfZQB945PIb9obapsEeEFIH69Omoy7PEWwXpxy8qNBx57aSIB0g3LeNeuf7xHsXPFQ90uJYtqRJCb1lR1lG5RrtLb5WzZwIG6AllfwGwqfVV+fhWAtYRI1TqYMEHfdMfnBQ/kj+Do9+O92HfdGddJF4Vjp7LACkMGUL7kfCPXi7LaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(86362001)(6666004)(6506007)(6512007)(6486002)(2906002)(8676002)(33716001)(66946007)(186003)(4326008)(9686003)(66476007)(66556008)(6916009)(38100700002)(316002)(26005)(44832011)(5660300002)(4744005)(8936002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FBA5bsHDcQ1vOtwInLHJhQ/v26JWJxg237rqhQpBDr6pSmxGXai0Lw2Z92iB?=
 =?us-ascii?Q?te2pi6Zc0tZvJl7SncEZv5Vy3j7UgoLxfp/qXqIiaa3LjkbWGL3PEbB7aQej?=
 =?us-ascii?Q?pOB/FKUivM4Ecz/TztpbWF2QLHp+8cRhb+VHdZNMOazWuYDB/E/zUGagOdBG?=
 =?us-ascii?Q?lVIO1EMCfIE1x4KSkxiXT15tm7C8eV9ijPVhC5Mg6c8d+lU2nXDS+dCeKb1C?=
 =?us-ascii?Q?ib3T7sBd40Kxmx7k+D0U/2Id057tLKz8i4nW8HFGSyEC1Zk5xt5+VtYzVCx7?=
 =?us-ascii?Q?dd2CX8boqPBku9EvBGLKDJD5vsI4TAhSq6mhTxmpELH+8gK1FSCKE+7W7duz?=
 =?us-ascii?Q?PzilFo2Eb2ZrMwgKeeT7tYvHbIRwU9rkGVKUbfD/5D3xHhbgwDz1cI2ew2Id?=
 =?us-ascii?Q?cq95KNYw6QxzRoCQFjOrM0+fNKjxQm5DDjrIzxn2TQf1srXgX7Ui7FZoypzr?=
 =?us-ascii?Q?OgWc1kxgbtplTN6O3tusoZuA1e4wSfz8LdqrLm+y/iNBxIApgzX5z7Sd837D?=
 =?us-ascii?Q?tzgy5/Qe7PNcnrLjvSK9IKxcRChOPnGJqf3LybDOYTeUDS70/YvkoS4wQ6FM?=
 =?us-ascii?Q?1lFwr+uoSnsm9gK4j9Oy1OOgEYp3p5oMquIHRS9JAEriEQ2dMQy3VO3kxxbA?=
 =?us-ascii?Q?2hibmx65jF1XyYCXrikI6VMgkbv1PvGEfBDSEyyYR6MxEV3Jpve2FmaWUOk+?=
 =?us-ascii?Q?kEZjXIR8rSmebqQCiqMgnd5cQ957nJDYmVgsTi4QPMDb2o0xpAMoUlP+3AqK?=
 =?us-ascii?Q?gfMdCj4JyQx4aDyvwwIn5vU/OAtApN+M1lJRbV5M6YG3JHOUFlENvQ7lH4LT?=
 =?us-ascii?Q?gReUy0kz+QikDOpLWau9Mrhbbm3C8j2iwGGJ1bVImEd8/JRWo3oLdrVoxdo8?=
 =?us-ascii?Q?hCfJt3uLrEhHF9eT3tqpUCpfuqBKqMCi9qNHw2poqAvP7kJ9U1T0gbENzS2f?=
 =?us-ascii?Q?igmROc8JihftoWlZ6wBWRCPdQb3mruV+4SKA2s2sHM8nlQNne7QyvyOae+sa?=
 =?us-ascii?Q?oZ9Unnq2retMotYQ8OGWetS+/go01N5d4a7sIc7lyyx8qncRFc25ex8KTw/d?=
 =?us-ascii?Q?FtflJ0LWFC2lC2rnfVhRz6BYTu+CyOMlOzrImlPMxSN0IuEWHAWLVBW2QEAR?=
 =?us-ascii?Q?F5JMx2VsRdVMv7JobYfiaiwGNgWUCVkctocg6VnwY7+KPUL2cGu30ymhohRA?=
 =?us-ascii?Q?J0eTcbLmebDxV7qboh99Y+tfXNOKh66+xtavGe0PObBvDFG628D5kLm1gUF6?=
 =?us-ascii?Q?rtOVJzaPYT2tdFGA/SQR+Ujp89USkPUz18YHu9yuTw2yOSGnbrZuI9hYy5G4?=
 =?us-ascii?Q?nyv2OENsAtILTSjStA/dR7OlAW4HFjts8uzDAEyJEB8wmT/ULWRIblWa09nb?=
 =?us-ascii?Q?ojgKCWV2lPABaq3BsD4PctI3fqufujjNQUYS33rUqrB9UqZcnzrhJ0C5qP8B?=
 =?us-ascii?Q?dRAWmN+ygKiS2tIXfLQGdoQRaU/Hg7Hu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0a7bd8-9412-464a-ea27-08da021c927c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 22:31:36.7283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpFGTiC2tgSM9vfMPZlSci46uW7GmTt2Us+ySm1PvTJ8vBg0S1s83MHhlPKxpR3/vGE1I1kiFdbwAO20WhPTOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5137
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 14, 2022 at 02:09:07PM +0100, Borislav Petkov wrote:
> On Thu, Jan 27, 2022 at 08:41:09PM +0000, Yazen Ghannam wrote:
> > @@ -1326,20 +1331,7 @@ static int denormalize_addr(struct addr_ctx *ctx)
> >  		return -EINVAL;
> >  	}
> >  
> > -	if (num_intlv_bits > 0) {
> > -		u64 temp_addr_i;
> > -
> > -		/*
> > -		 * The pre-interleaved address consists of XXXXXXIIIYYYYY
> > -		 * where III is the ID for this CS, and XXXXXXYYYYY are the
> > -		 * address bits from the post-interleaved address.
> > -		 * "num_intlv_bits" has been calculated to tell us how many "I"
> > -		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
> > -		 * there are (where "I" starts).
> > -		 */
> 
> That comment looks useful, why remove it?
>

No firm reason. I just got the feeling it wasn't very useful. But I'll keep it
in case others find it helpful.

Thanks,
Yazen
 
