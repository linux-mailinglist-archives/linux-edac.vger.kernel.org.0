Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1291E7D18
	for <lists+linux-edac@lfdr.de>; Fri, 29 May 2020 14:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgE2MYk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 29 May 2020 08:24:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgE2MYk (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 29 May 2020 08:24:40 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 875482075A;
        Fri, 29 May 2020 12:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590755077;
        bh=qIgOcKgzsfDEukilfXKPcLXfk25cWE+32+03rNcfOSk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CFc6/wNPT8htf9bGCO7S0CGgj50dIOjqLlOjNd4bdiBZuxBn8KPn9csKo0+HrvIq1
         mMUKINoALNqHX+KxZ9eKQQzZiClGNkyPQ0YPQLCcwUw2nYJ389Fl9YaoGDSYQwKwW+
         23yNgOYPggRXTYMMXga4VnmYFrPeQPELoEYJT10w=
Date:   Fri, 29 May 2020 14:24:33 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     lvying6 <lvying6@huawei.com>
Cc:     <linux-edac@vger.kernel.org>, <guanyalong@huawei.com>,
        <wuyun.wu@huawei.com>, <tanxiaofei@huawei.com>
Subject: Re: [PATCH 1/2] rasdaemon: add rbtree support for page record
Message-ID: <20200529142433.1cdcb3c8@coco.lan>
In-Reply-To: <1590740663-6664-2-git-send-email-lvying6@huawei.com>
References: <1590740663-6664-1-git-send-email-lvying6@huawei.com>
        <1590740663-6664-2-git-send-email-lvying6@huawei.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Fri, 29 May 2020 16:24:22 +0800
lvying6 <lvying6@huawei.com> escreveu:

> From: wuyun <wuyun.wu@huawei.com>
> 
> The rbtree is very efficient for recording and querying fault page info.
> 
> Signed-off-by: lvying <lvying6@huawei.com>
> ---
>  Makefile.am |   4 +-
>  rbtree.c    | 384 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  rbtree.h    | 165 ++++++++++++++++++++++++++
>  3 files changed, 551 insertions(+), 2 deletions(-)
>  create mode 100644 rbtree.c
>  create mode 100644 rbtree.h
> 
> diff --git a/Makefile.am b/Makefile.am
> index 843b538..2ff742d 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -17,7 +17,7 @@ all-local: $(SYSTEMD_SERVICES)
>  
>  sbin_PROGRAMS = rasdaemon
>  rasdaemon_SOURCES = rasdaemon.c ras-events.c ras-mc-handler.c \
> -		    bitfield.c
> +		    bitfield.c rbtree.c

I would move the change at Makefile.am to the next patch.

As I'll comment there, I'd like to have a separate configure
option for each feature provided by the rasdaemon.

So, I would like to see something like:

	if WITH_PG_RECORD
	   rasdaemon_SOURCES += rbtree.c ras-page-isolation.c
	endif

at the Makefile.am (after applying both patches)

>  if WITH_SQLITE3
>     rasdaemon_SOURCES += ras-record.c
>  endif
> @@ -59,7 +59,7 @@ rasdaemon_LDADD = -lpthread $(SQLITE3_LIBS) libtrace/libtrace.a
>  include_HEADERS = config.h  ras-events.h  ras-logger.h  ras-mc-handler.h \
>  		  ras-aer-handler.h ras-mce-handler.h ras-record.h bitfield.h ras-report.h \
>  		  ras-extlog-handler.h ras-arm-handler.h ras-non-standard-handler.h \
> -		  ras-devlink-handler.h ras-diskerror-handler.h
> +		  ras-devlink-handler.h ras-diskerror-handler.h rbtree.h
>  
>  # This rule can't be called with more than one Makefile job (like make -j8)
>  # I can't figure out a way to fix that
> diff --git a/rbtree.c b/rbtree.c
> new file mode 100644
> index 0000000..d9b1bd4
> --- /dev/null
> +++ b/rbtree.c
> @@ -0,0 +1,384 @@
> +/*
> +  Red Black Trees
> +  (C) 1999  Andrea Arcangeli <andrea@suse.de>
> +  (C) 2002  David Woodhouse <dwmw2@infradead.org>
> +  Taken from the Linux 2.6.30 source with some minor modificatons.
> +
> +  This program is free software; you can redistribute it and/or modify
> +  it under the terms of the GNU General Public License as published by
> +  the Free Software Foundation; either version 2 of the License, or
> +  (at your option) any later version.
> +
> +  This program is distributed in the hope that it will be useful,
> +  but WITHOUT ANY WARRANTY; without even the implied warranty of
> +  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +  GNU General Public License for more details.
> +
> +  You should have received a copy of the GNU General Public License
> +  along with this program; if not, write to the Free Software
> +  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> +
> +  linux/lib/rbtree.c
> +*/
> +
> +#include "rbtree.h"
> +
> +static void __rb_rotate_left(struct rb_node *node, struct rb_root *root)
> +{
> +	struct rb_node *right = node->rb_right;
> +	struct rb_node *parent = rb_parent(node);
> +
> +	if ((node->rb_right = right->rb_left))
> +		rb_set_parent(right->rb_left, node);
> +	right->rb_left = node;
> +
> +	rb_set_parent(right, parent);
> +
> +	if (parent)
> +	{
> +		if (node == parent->rb_left)
> +			parent->rb_left = right;
> +		else
> +			parent->rb_right = right;
> +	}
> +	else
> +		root->rb_node = right;
> +	rb_set_parent(node, right);
> +}
> +
> +static void __rb_rotate_right(struct rb_node *node, struct rb_root *root)
> +{
> +	struct rb_node *left = node->rb_left;
> +	struct rb_node *parent = rb_parent(node);
> +
> +	if ((node->rb_left = left->rb_right))
> +		rb_set_parent(left->rb_right, node);
> +	left->rb_right = node;
> +
> +	rb_set_parent(left, parent);
> +
> +	if (parent)
> +	{
> +		if (node == parent->rb_right)
> +			parent->rb_right = left;
> +		else
> +			parent->rb_left = left;
> +	}
> +	else
> +		root->rb_node = left;
> +	rb_set_parent(node, left);
> +}
> +
> +void rb_insert_color(struct rb_node *node, struct rb_root *root)
> +{
> +	struct rb_node *parent, *gparent;
> +
> +	while ((parent = rb_parent(node)) && rb_is_red(parent))
> +	{
> +		gparent = rb_parent(parent);
> +
> +		if (parent == gparent->rb_left)
> +		{
> +			{
> +				register struct rb_node *uncle = gparent->rb_right;
> +				if (uncle && rb_is_red(uncle))
> +				{
> +					rb_set_black(uncle);
> +					rb_set_black(parent);
> +					rb_set_red(gparent);
> +					node = gparent;
> +					continue;
> +				}
> +			}
> +
> +			if (parent->rb_right == node)
> +			{
> +				struct rb_node *tmp;
> +				__rb_rotate_left(parent, root);
> +				tmp = parent;
> +				parent = node;
> +				node = tmp;
> +			}
> +
> +			rb_set_black(parent);
> +			rb_set_red(gparent);
> +			__rb_rotate_right(gparent, root);
> +		} else {
> +			{
> +				struct rb_node *uncle = gparent->rb_left;
> +				if (uncle && rb_is_red(uncle))
> +				{
> +					rb_set_black(uncle);
> +					rb_set_black(parent);
> +					rb_set_red(gparent);
> +					node = gparent;
> +					continue;
> +				}
> +			}
> +
> +			if (parent->rb_left == node)
> +			{
> +				struct rb_node *tmp;
> +				__rb_rotate_right(parent, root);
> +				tmp = parent;
> +				parent = node;
> +				node = tmp;
> +			}
> +
> +			rb_set_black(parent);
> +			rb_set_red(gparent);
> +			__rb_rotate_left(gparent, root);
> +		}
> +	}
> +
> +	rb_set_black(root->rb_node);
> +}
> +
> +static void __rb_erase_color(struct rb_node *node, struct rb_node *parent,
> +			     struct rb_root *root)
> +{
> +	struct rb_node *other;
> +
> +	while ((!node || rb_is_black(node)) && node != root->rb_node)
> +	{
> +		if (parent->rb_left == node)
> +		{
> +			other = parent->rb_right;
> +			if (rb_is_red(other))
> +			{
> +				rb_set_black(other);
> +				rb_set_red(parent);
> +				__rb_rotate_left(parent, root);
> +				other = parent->rb_right;
> +			}
> +			if ((!other->rb_left || rb_is_black(other->rb_left)) &&
> +			    (!other->rb_right || rb_is_black(other->rb_right)))
> +			{
> +				rb_set_red(other);
> +				node = parent;
> +				parent = rb_parent(node);
> +			}
> +			else
> +			{
> +				if (!other->rb_right || rb_is_black(other->rb_right))
> +				{
> +					rb_set_black(other->rb_left);
> +					rb_set_red(other);
> +					__rb_rotate_right(other, root);
> +					other = parent->rb_right;
> +				}
> +				rb_set_color(other, rb_color(parent));
> +				rb_set_black(parent);
> +				rb_set_black(other->rb_right);
> +				__rb_rotate_left(parent, root);
> +				node = root->rb_node;
> +				break;
> +			}
> +		}
> +		else
> +		{
> +			other = parent->rb_left;
> +			if (rb_is_red(other))
> +			{
> +				rb_set_black(other);
> +				rb_set_red(parent);
> +				__rb_rotate_right(parent, root);
> +				other = parent->rb_left;
> +			}
> +			if ((!other->rb_left || rb_is_black(other->rb_left)) &&
> +			    (!other->rb_right || rb_is_black(other->rb_right)))
> +			{
> +				rb_set_red(other);
> +				node = parent;
> +				parent = rb_parent(node);
> +			}
> +			else
> +			{
> +				if (!other->rb_left || rb_is_black(other->rb_left))
> +				{
> +					rb_set_black(other->rb_right);
> +					rb_set_red(other);
> +					__rb_rotate_left(other, root);
> +					other = parent->rb_left;
> +				}
> +				rb_set_color(other, rb_color(parent));
> +				rb_set_black(parent);
> +				rb_set_black(other->rb_left);
> +				__rb_rotate_right(parent, root);
> +				node = root->rb_node;
> +				break;
> +			}
> +		}
> +	}
> +	if (node)
> +		rb_set_black(node);
> +}
> +
> +void rb_erase(struct rb_node *node, struct rb_root *root)
> +{
> +	struct rb_node *child, *parent;
> +	int color;
> +
> +	if (!node->rb_left)
> +		child = node->rb_right;
> +	else if (!node->rb_right)
> +		child = node->rb_left;
> +	else
> +	{
> +		struct rb_node *old = node, *left;
> +
> +		node = node->rb_right;
> +		while ((left = node->rb_left) != NULL)
> +			node = left;
> +		child = node->rb_right;
> +		parent = rb_parent(node);
> +		color = rb_color(node);
> +
> +		if (child)
> +			rb_set_parent(child, parent);
> +		if (parent == old) {
> +			parent->rb_right = child;
> +			parent = node;
> +		} else
> +			parent->rb_left = child;
> +
> +		node->rb_parent_color = old->rb_parent_color;
> +		node->rb_right = old->rb_right;
> +		node->rb_left = old->rb_left;
> +
> +		if (rb_parent(old))
> +		{
> +			if (rb_parent(old)->rb_left == old)
> +				rb_parent(old)->rb_left = node;
> +			else
> +				rb_parent(old)->rb_right = node;
> +		} else
> +			root->rb_node = node;
> +
> +		rb_set_parent(old->rb_left, node);
> +		if (old->rb_right)
> +			rb_set_parent(old->rb_right, node);
> +		goto color;
> +	}
> +
> +	parent = rb_parent(node);
> +	color = rb_color(node);
> +
> +	if (child)
> +		rb_set_parent(child, parent);
> +	if (parent)
> +	{
> +		if (parent->rb_left == node)
> +			parent->rb_left = child;
> +		else
> +			parent->rb_right = child;
> +	}
> +	else
> +		root->rb_node = child;
> +
> + color:
> +	if (color == RB_BLACK)
> +		__rb_erase_color(child, parent, root);
> +}
> +
> +/*
> + * This function returns the first node (in sort order) of the tree.
> + */
> +struct rb_node *rb_first(const struct rb_root *root)
> +{
> +	struct rb_node	*n;
> +
> +	n = root->rb_node;
> +	if (!n)
> +		return NULL;
> +	while (n->rb_left)
> +		n = n->rb_left;
> +	return n;
> +}
> +
> +struct rb_node *rb_last(const struct rb_root *root)
> +{
> +	struct rb_node	*n;
> +
> +	n = root->rb_node;
> +	if (!n)
> +		return NULL;
> +	while (n->rb_right)
> +		n = n->rb_right;
> +	return n;
> +}
> +
> +struct rb_node *rb_next(const struct rb_node *node)
> +{
> +	struct rb_node *parent;
> +
> +	if (rb_parent(node) == node)
> +		return NULL;
> +
> +	/* If we have a right-hand child, go down and then left as far
> +	   as we can. */
> +	if (node->rb_right) {
> +		node = node->rb_right;
> +		while (node->rb_left)
> +			node=node->rb_left;
> +		return (struct rb_node *)node;
> +	}
> +
> +	/* No right-hand children.  Everything down and left is
> +	   smaller than us, so any 'next' node must be in the general
> +	   direction of our parent. Go up the tree; any time the
> +	   ancestor is a right-hand child of its parent, keep going
> +	   up. First time it's a left-hand child of its parent, said
> +	   parent is our 'next' node. */
> +	while ((parent = rb_parent(node)) && node == parent->rb_right)
> +		node = parent;
> +
> +	return parent;
> +}
> +
> +struct rb_node *rb_prev(const struct rb_node *node)
> +{
> +	struct rb_node *parent;
> +
> +	if (rb_parent(node) == node)
> +		return NULL;
> +
> +	/* If we have a left-hand child, go down and then right as far
> +	   as we can. */
> +	if (node->rb_left) {
> +		node = node->rb_left;
> +		while (node->rb_right)
> +			node=node->rb_right;
> +		return (struct rb_node *)node;
> +	}
> +
> +	/* No left-hand children. Go up till we find an ancestor which
> +	   is a right-hand child of its parent */
> +	while ((parent = rb_parent(node)) && node == parent->rb_left)
> +		node = parent;
> +
> +	return parent;
> +}
> +
> +void rb_replace_node(struct rb_node *victim, struct rb_node *new,
> +		     struct rb_root *root)
> +{
> +	struct rb_node *parent = rb_parent(victim);
> +
> +	/* Set the surrounding nodes to point to the replacement */
> +	if (parent) {
> +		if (victim == parent->rb_left)
> +			parent->rb_left = new;
> +		else
> +			parent->rb_right = new;
> +	} else {
> +		root->rb_node = new;
> +	}
> +	if (victim->rb_left)
> +		rb_set_parent(victim->rb_left, new);
> +	if (victim->rb_right)
> +		rb_set_parent(victim->rb_right, new);
> +
> +	/* Copy the pointers/colour from the victim to the replacement */
> +	*new = *victim;
> +}
> diff --git a/rbtree.h b/rbtree.h
> new file mode 100644
> index 0000000..a8a0459
> --- /dev/null
> +++ b/rbtree.h
> @@ -0,0 +1,165 @@
> +/*
> +  Red Black Trees
> +  (C) 1999  Andrea Arcangeli <andrea@suse.de>
> +  Taken from the Linux 2.6.30 source.
> +
> +  This program is free software; you can redistribute it and/or modify
> +  it under the terms of the GNU General Public License as published by
> +  the Free Software Foundation; either version 2 of the License, or
> +  (at your option) any later version.
> +
> +  This program is distributed in the hope that it will be useful,
> +  but WITHOUT ANY WARRANTY; without even the implied warranty of
> +  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +  GNU General Public License for more details.
> +
> +  You should have received a copy of the GNU General Public License
> +  along with this program; if not, write to the Free Software
> +  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> +
> +  linux/include/linux/rbtree.h
> +
> +  To use rbtrees you'll have to implement your own insert and search cores.
> +  This will avoid us to use callbacks and to drop drammatically performances.
> +  I know it's not the cleaner way,  but in C (not in C++) to get
> +  performances and genericity...
> +
> +  Some example of insert and search follows here. The search is a plain
> +  normal search over an ordered tree. The insert instead must be implemented
> +  int two steps: as first thing the code must insert the element in
> +  order as a red leaf in the tree, then the support library function
> +  rb_insert_color() must be called. Such function will do the
> +  not trivial work to rebalance the rbtree if necessary.
> +
> +-----------------------------------------------------------------------
> +static inline struct page * rb_search_page_cache(struct inode * inode,
> +						 unsigned long offset)
> +{
> +	struct rb_node * n = inode->i_rb_page_cache.rb_node;
> +	struct page * page;
> +
> +	while (n)
> +	{
> +		page = rb_entry(n, struct page, rb_page_cache);
> +
> +		if (offset < page->offset)
> +			n = n->rb_left;
> +		else if (offset > page->offset)
> +			n = n->rb_right;
> +		else
> +			return page;
> +	}
> +	return NULL;
> +}
> +
> +static inline struct page * __rb_insert_page_cache(struct inode * inode,
> +						   unsigned long offset,
> +						   struct rb_node * node)
> +{
> +	struct rb_node ** p = &inode->i_rb_page_cache.rb_node;
> +	struct rb_node * parent = NULL;
> +	struct page * page;
> +
> +	while (*p)
> +	{
> +		parent = *p;
> +		page = rb_entry(parent, struct page, rb_page_cache);
> +
> +		if (offset < page->offset)
> +			p = &(*p)->rb_left;
> +		else if (offset > page->offset)
> +			p = &(*p)->rb_right;
> +		else
> +			return page;
> +	}
> +
> +	rb_link_node(node, parent, p);
> +
> +	return NULL;
> +}
> +
> +static inline struct page * rb_insert_page_cache(struct inode * inode,
> +						 unsigned long offset,
> +						 struct rb_node * node)
> +{
> +	struct page * ret;
> +	if ((ret = __rb_insert_page_cache(inode, offset, node)))
> +		goto out;
> +	rb_insert_color(node, &inode->i_rb_page_cache);
> + out:
> +	return ret;
> +}
> +-----------------------------------------------------------------------
> +*/
> +
> +#ifndef	_LINUX_RBTREE_H
> +#define	_LINUX_RBTREE_H
> +
> +#include <stddef.h>
> +
> +#define container_of(ptr, type, member) ({			\
> +	const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
> +	(type *)( (char *)__mptr - offsetof(type,member) );})
> +
> +struct rb_node
> +{
> +	unsigned long  rb_parent_color;
> +#define	RB_RED		0
> +#define	RB_BLACK	1
> +	struct rb_node *rb_right;
> +	struct rb_node *rb_left;
> +} __attribute__((aligned(sizeof(long))));
> +    /* The alignment might seem pointless, but allegedly CRIS needs it */
> +
> +struct rb_root
> +{
> +	struct rb_node *rb_node;
> +};
> +
> +
> +#define rb_parent(r)   ((struct rb_node *)((r)->rb_parent_color & ~3))
> +#define rb_color(r)   ((r)->rb_parent_color & 1)
> +#define rb_is_red(r)   (!rb_color(r))
> +#define rb_is_black(r) rb_color(r)
> +#define rb_set_red(r)  do { (r)->rb_parent_color &= ~1; } while (0)
> +#define rb_set_black(r)  do { (r)->rb_parent_color |= 1; } while (0)
> +
> +static inline void rb_set_parent(struct rb_node *rb, struct rb_node *p)
> +{
> +	rb->rb_parent_color = (rb->rb_parent_color & 3) | (unsigned long)p;
> +}
> +static inline void rb_set_color(struct rb_node *rb, int color)
> +{
> +	rb->rb_parent_color = (rb->rb_parent_color & ~1) | color;
> +}
> +
> +#define RB_ROOT	(struct rb_root) { NULL, }
> +#define	rb_entry(ptr, type, member) container_of(ptr, type, member)
> +
> +#define RB_EMPTY_ROOT(root)	((root)->rb_node == NULL)
> +#define RB_EMPTY_NODE(node)	(rb_parent(node) == node)
> +#define RB_CLEAR_NODE(node)	(rb_set_parent(node, node))
> +
> +extern void rb_insert_color(struct rb_node *, struct rb_root *);
> +extern void rb_erase(struct rb_node *, struct rb_root *);
> +
> +/* Find logical next and previous nodes in a tree */
> +extern struct rb_node *rb_next(const struct rb_node *);
> +extern struct rb_node *rb_prev(const struct rb_node *);
> +extern struct rb_node *rb_first(const struct rb_root *);
> +extern struct rb_node *rb_last(const struct rb_root *);
> +
> +/* Fast replacement of a single node without remove/rebalance/add/rebalance */
> +extern void rb_replace_node(struct rb_node *victim, struct rb_node *new,
> +			    struct rb_root *root);
> +
> +static inline void rb_link_node(struct rb_node * node, struct rb_node * parent,
> +				struct rb_node ** rb_link)
> +{
> +	node->rb_parent_color = (unsigned long )parent;
> +	node->rb_left = node->rb_right = NULL;
> +
> +	*rb_link = node;
> +}
> +
> +#endif	/* _LINUX_RBTREE_H */



Thanks,
Mauro
