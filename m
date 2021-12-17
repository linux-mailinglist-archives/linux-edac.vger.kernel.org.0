Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9950E4788A0
	for <lists+linux-edac@lfdr.de>; Fri, 17 Dec 2021 11:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbhLQKUq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Dec 2021 05:20:46 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53404 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234763AbhLQKUq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 17 Dec 2021 05:20:46 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BH8A0cX031676;
        Fri, 17 Dec 2021 10:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=0cKmCuvVtRFVTPaoKNwAjiTbN6a1e5ooUifFuZnbJBE=;
 b=DQmk9fVs8aG53dE+SepJiNaEiqQJ/i0wKzpZZkeCbkj8kG/tTLN7Lj3Q25PLydcnVSVb
 FeNBstTC8v2zpmSFb7eoqlYXkSA2ZMVhoD55LIwkBvRz+pELtEw4kRJ0JRarkCqqD72c
 2eMCP1X0ZDdPeIIMxr2I1M/D3wg2eIKFm/TVvzDPotw3QRCLVHyvQV0rrRTLf6HqjImP
 avRnHXXnAJ4HOAvCXCP5TUWK08M44ao3NmY3m98CnuMbpn93gWxw0MkrVts3A/NOrDHw
 3TuWKNq96iN27WrQMh8uiIY1Xvn86H7vgZI7RvbiGsDHdOfA8k2Vk5fUFXdM6Vpwqqo/ mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykmbndet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 10:20:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BHAFvZk059515;
        Fri, 17 Dec 2021 10:20:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by userp3020.oracle.com with ESMTP id 3cvnevcf29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 10:20:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXx9YHbWkVIt4heQAwbGevK3jXlodvrVmzqp5KIZElca0So7psES0ffgwp9t1qUxc0pvtuEFVIQ3ZSDo4+YhfZowN0eJ8ui4DHqAG1CLA4pZyxmdOBXz1t9eBkhuFCFIw4dr/6Qv49otJ77MYSbw/fYOcX6BFUV/bTJVH7JlXfLKNAGnCgVzCO+I/vJ+kd4asOLlLQ/SHuUsOOyCGAWFng/u3YTzRbNmWP+H0X+Q4pBfKDPuGYfo+d9GBLmDJVekv5CECxHfvBYLXTzu4VTLxA1jFOq48K37xCmSOj21jB8rdYbO8pazKWPAo6x8zCkWKPQMQZrDPOmFNZpvjISTKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cKmCuvVtRFVTPaoKNwAjiTbN6a1e5ooUifFuZnbJBE=;
 b=SanAfz7MhrJNFxiLf+sQqblqe+00ZmITafjfuEoLPeus8IIFWgCBeSrlQ3QwEapxDBnvs/Ajt7IqyLGhCW5bqdmMPuBB3U98uuQkyDm51nMBI52hEc0Dr8X6czcD/Ek9PYIjhR2q/plN4i+fG5sUKw3eiMWMnCgJS94qHq6tEUL6h4M4NzuEJhEqQ/hi9lLNr/17bTz0BK3prH+XCu4QLgwwhSZJVhkxUzEgLmEA0AHkR6PrzeNI9zMTyM4OXPpb/uph6sKRPLp5xT1Bl0LTrCDsTZSx/fI5wXVlKeRrNySvTNFErwAsnQD8bmZTctcACEX1kt0Rte3pN7W2gDKOzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cKmCuvVtRFVTPaoKNwAjiTbN6a1e5ooUifFuZnbJBE=;
 b=eE4s18l4jfgr3q2M2ys5eM4kALesP/HJdGRIq4i+he9u8KVNMTh2iO6iEiYq/QIlVVFHDnzBQzlsm5VY9Y+yEIywAyXEe6k7DRXP+Cbg7L60vXmMmFBC82xACy4ymRPbNhNObY+Zg18DXSjrYc9YZDAg14r5r4z875D36sJs8PY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5850.namprd10.prod.outlook.com
 (2603:10b6:303:19c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Fri, 17 Dec
 2021 10:20:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 10:20:40 +0000
Date:   Fri, 17 Dec 2021 13:20:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     bp@suse.de
Cc:     linux-edac@vger.kernel.org
Subject: [bug report] x86/mce: Prevent severity computation from being
 instrumented
Message-ID: <20211217102029.GA29708@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0146.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f50104c-182b-44f0-e0b0-08d9c146e013
X-MS-TrafficTypeDiagnostic: MW5PR10MB5850:
X-Microsoft-Antispam-PRVS: <MW5PR10MB5850186A7E4BA8A11FFB22AE8E789@MW5PR10MB5850.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nf1d1mAVgNGdqN0y8t5NOUjnnyELrPcUExd31TNkTVb7uE88vkjMA11Fl6MNYK+zBUbEo698NuFJ8z7QM3+LSKBeUfdwvLFZSuv9/sPadT5H6syc+c2dCgM5gZzBLTu8AiEQ6m0vgiwCKYDetBt7Z0cYnizRzdoqulKLqQ4HAFgpDgupYpBE/mekYXaBXSqwj6JcZzsihVHz+7RYTzp8gGF5WSpOIooPp2HMlEc7kFfqEQeNZ8EZOp6DVmp10J4bpw9JoIPdFrlKJNYuLkV1dvT1Ml3xfIFsK3jLlX+6IPd0ivxT8rJ/yY0Xl6C1fBC3vR8ufejgwaCcO9eZl3Q2e0LRA+XjPxTly5BUhWvc2ALBxrOfo1VabcV6x4aKthmw3Blw2MU4WsU5ac0GgGCCMWOwqHwPD0FBVbrzfQ6K6p9B6FT8Eig2Xe+i1Evd9eZZoWcV/BMUgRw1rzC0MyQUnoVTFtE+Z1ekY4G9fRQDRs2z5rCSuJS5x1FtYaEVB547uffcLJlOjmduIddyabfDG0pfFRIklVV+RxR02OBeazFB9VXJJDf14CGptJp1fzCrv+b8ha63Jw53881SJFgJY7LP+HW06o2pYhkH/LhMXir7S9d2bid9FVse05pbBF9MPAVxKs+oWYV45r//VHYUbMlLaQrCAE7GMicjzLPaL3eRFyE5U5+5YOreohUYTeEx4qtsR3eEkMQnbOjp/lNmHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(33716001)(2906002)(38100700002)(186003)(4744005)(33656002)(6506007)(8676002)(66946007)(6916009)(4326008)(6666004)(1076003)(38350700002)(26005)(52116002)(9686003)(8936002)(83380400001)(6512007)(508600001)(66556008)(66476007)(5660300002)(6486002)(44832011)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LB2T75+iJvyvjRNN2BIo72OiZvBJd04adMgdEXtwn9fh8vlHmjYBQ3tIj708?=
 =?us-ascii?Q?rMUKHz5nt0Q7jcnBauOnjLsMNCefsUj2enyoWUbuO9jsXQ/A2vDXMMWo3aVL?=
 =?us-ascii?Q?kqf9ou8yR2BPd3pQC4JO3p/c/LiLOUjEEbTzRMoRKK4KO0vyyZU1HWjY8lX7?=
 =?us-ascii?Q?ixNP3VExYucqrEK1EWR8jgg7/q5MS4w6VLThhnHXJQ2jNfVwhZMp2WvL9Bsw?=
 =?us-ascii?Q?HuPkfQd7TWPVwX5SZbKKONe8Q9f4Qk6SJpJsxhQHuJr0ZKU4U3iQWZFiWN44?=
 =?us-ascii?Q?LLqNgbNeavlVDgS0VK9j2VbUZBU8/7OQ2Rp/HqIzIFiqNVQRjLmBHwEAE40u?=
 =?us-ascii?Q?Esc5NNQRnCfrp14V/pKR/kkAdkz4fukrQSjEDgGH73yvUFzxMFtUAx1sGsTr?=
 =?us-ascii?Q?qjt7QLwSDqPNO25E6Pd7Froyzxh4qmnyAH7FDYRf0tfgHvP/mIN0NhDPUzys?=
 =?us-ascii?Q?ONuME+EGa/JrdzU8xp/JD543vdGwNoEDqTwVx9seage3b7ph6xZMJjcQ5WqK?=
 =?us-ascii?Q?UUcOJGpjVGfjnuMSX7Pc65jeUkjQSJTJYZrt4iLx/KZ7G1XNKY04tfcY9jKL?=
 =?us-ascii?Q?k+MxWPSEc5qlGEpNvACDCuUxvcBhu0w8RirHKwEfkLgTUeXJIS4bZWpN8gTk?=
 =?us-ascii?Q?wEb4vx5HG9eKGP7jKQmcCNV4VO+KH7NU9SEISiycUZi4bcLCkrtK1Ij66Jmw?=
 =?us-ascii?Q?GiWlm7ydUhbBLXtgysAwt4l1nmE0KyyhS5pARZUjdwfFW0mW6fLvxYc5Exd3?=
 =?us-ascii?Q?WokZdOFAvJxdO2oxAtwWZWEAWeH9qZfKx5oHoPgl4LraH3yVikWyDjYBhG8+?=
 =?us-ascii?Q?EmWT+dsYMQ/Z5MS/+uWn/qeO3kwV3M7lXordhudLoJW/tuKi1EOB1L76O4AJ?=
 =?us-ascii?Q?s4ZXTVcvZYFfCjeYsmiDMI+GL0B2tPWb6+tuh/OMT8Dg/yY/KpmJKsl3lnU6?=
 =?us-ascii?Q?NgWqOU0EpaYyBUmB1zTr0PkkvcyUSxuQXqmfbLwVKFSX0PcirSAfo1Dkufg3?=
 =?us-ascii?Q?aEIxhL+ySaTHyo6t9jg5oANiOLwNRvU4izr2o9bD+ECg1U7yG2QIAD8q+xVS?=
 =?us-ascii?Q?C4j2IopsA8sOYeqte2KbV/ZmKCB5+CjTE6ONpwOVVLztw3fN6+7AzOgKJiO7?=
 =?us-ascii?Q?b6OLZqPZuFJKHA0XDHMvfzTu/fexZKs5T6QytfrUUqKEWkLsFDsFVr7hL942?=
 =?us-ascii?Q?WxlA3HipDdDaRgfSFUPUle/nfdga6t1nCCKdAq6ckqHwYqDtq6J8X0wKhbn+?=
 =?us-ascii?Q?+LyPmbKNTUYfIdU01OdBd+QceAV78e5yXE2AkGgbSe2jCzwzncf33OenaEZ3?=
 =?us-ascii?Q?8wOUPJVzOu0CvBxHKSYDV2IXZff5PJXOps0CNQRss8I4gUZvOVjXQgzr/Fcx?=
 =?us-ascii?Q?yUDCwIcAKNxs4/WMSUnTpD0H/eU/fOZPfl/oZuiCMNKtSSeqDxY5bL3B/klG?=
 =?us-ascii?Q?bAHnwyWggTqGLlp6F5bpPdIzdhnJY7nxgOU1/i2QQeZZdDBq66HrIAcgO/9j?=
 =?us-ascii?Q?v7+F/bJ5lnxtiXajIIrDhjMfzmHoK/p+FKZmySiSbWX3yYc9hgJZUxZrHDST?=
 =?us-ascii?Q?Otg2CcJ8Lx7+w2f3mN8hjlxNM8WRWMaIEk6lkjGuGUUHtDhTvwVXJpCj+DZN?=
 =?us-ascii?Q?zxGlW1h4x90LYprRIhCkiR78RpVDxt06hmJfID3HMBo7dbLdF6SX4KNzV8BF?=
 =?us-ascii?Q?Oalx/sqX9zrjaITV0kOER+E8isk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f50104c-182b-44f0-e0b0-08d9c146e013
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 10:20:40.2255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nnkSs/muYRck4QNF5+Uv9jN89RtqIrCSvS6suxQehTMSdTrKv7DgYFLGk1kszf9hDBufFz+zUCVELCimATdsxUlNiE/fD++TP+vFdRJ940=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5850
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=684 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112170059
X-Proofpoint-ORIG-GUID: bC7uQIBbp2QHU5MhlUeXij9qWX50jjTu
X-Proofpoint-GUID: bC7uQIBbp2QHU5MhlUeXij9qWX50jjTu
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello Borislav Petkov,

This is a semi-automatic email about new static checker warnings.

The patch 0a5b288e85bb: "x86/mce: Prevent severity computation from
being instrumented" from Oct 13, 2021, leads to the following Smatch
complaint:

    arch/x86/kernel/cpu/mce/severity.c:286 error_context()
    warn: variable dereferenced before check 'regs' (see line 280)

arch/x86/kernel/cpu/mce/severity.c
   279		fixup_type = ex_get_fixup_type(m->ip);
   280		copy_user  = is_copy_from_user(regs);
                                               ^^^^
New unchecked dereference

   281		instrumentation_end();
   282	
   283		switch (fixup_type) {
   284		case EX_TYPE_UACCESS:
   285		case EX_TYPE_COPY:
   286			if (!regs || !copy_user)
                             ^^^^
Old code checked for NULL

   287				return IN_KERNEL;
   288			m->kflags |= MCE_IN_KERNEL_COPYIN;

regards,
dan carpenter
